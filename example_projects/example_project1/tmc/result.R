library('testthat')
library('jsonlite')

#declaring variables to global environment that for example helperTMC.R can use
points <- list()
points_for_all_tests <- list()

#Checks if a single test passed
checkIfResultCorrect <- function(results) {
  ret <- TRUE
  for (result in results) {
    if (format(result) != "As expected") {
      ret <- FALSE
    }
  }
  return(ret)
}

#Checks whether all the tests in a single file passed
checkThatAllPassed <- function(test_output) {
  ret <- TRUE
  for (test in test_output) {
    if (!checkIfResultCorrect(test$results)) {
      ret <- FALSE
      break
    }
  }
  return(ret)
}

iteratorForAll <- 1

#Adds the points from a single test file to all the tests in the file
#returns points, so that the modified points list is updated
addPointsToAllTests <- function(test_output) {
  for (test in test_output) {
    points[[test$test]] <- c(points[[test$test]], points_for_all_tests[iteratorForAll])
    #print(points[[test$test]])
  }
  iteratorForAll = iteratorForAll + 1
  return (points)
}


#Returns message from failed results
#Currently supports only results that used calls
messageFromFailedResult <- function(result) {
  if(is.null(result$call)) return("")
  
  #language that failed the test. for example call expect_equal(1,2)
  language <- toString(result$call[[1]])
  
  return(paste(sep="", "Failed with call: ", language,"\n", result$message))
}

testthat_output <- list()
#Lists all the files in the path beginning with "test" and ending in ".R"
testFiles <- list.files(path="tests/testthat", pattern = "test.*\\.R", full.names = T, recursive = FALSE)
for (testFile in testFiles) {
  testFileOutput <- test_file(testFile, reporter = "silent")
  if (checkThatAllPassed(testFileOutput)) {
    #Modifies the points because they were added to all the tests.
    points <- addPointsToAllTests(testFileOutput)
  }
  #Adds the output from the tests in the file to the list
  testthat_output <- c(testthat_output, testFileOutput)
}

results = list()
#print(testthat_output[1])
for (test in testthat_output) {
  test_name <- test$test
  test_points <- points[[test_name]]

  #if there are no points for a test, lets assign an empty vector
  if (is.null(test_points)) {
    test_points <- vector()
  }

  test_failed <- FALSE
  test_status <- "passed"
  test_message <- ""

  for (result in test$results) {
    if (format(result) != "As expected") {
      test_failed <- TRUE
      test_status <- "failed"
      test_message <- paste(sep = "", test_message, messageFromFailedResult(result))
      test_points <- vector()
    }
  }

  if (test_failed) {
    print(paste(test_name, ": FAIL", sep = ""))
    print(paste("   ", test_message, sep = ""))
  } else {
    print(paste(test_name, ": PASS", sep = ""))
  }
  
  #Add test result to results:
  test_result <- list(backtrace=list(),
                      status=unbox(test_status),
                      name=unbox(format(test_name)),
                      message=unbox(test_message),
                      points=test_points)
  results[[length(results)+1]] <- test_result
}

#json utf-8 coded:
json <- enc2utf8(toJSON(results, pretty = FALSE))
json <- prettify(json)

#encode json to utf-8 and write file
write(json, ".results.json")
