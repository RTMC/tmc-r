library('testthat')
library('jsonlite')

#declaring variables to global environment that for example helperTMC.R can use
points <- list()
points_for_all_tests <- list()

#Checks if a single test passed
CheckIfResultCorrect <- function(test) {
  ret <- TRUE
  for (result in test$results) {
    if (format(result) != "As expected") {
      ret <- FALSE
    }
  }
  return (ret)
}

#Checks whether all the tests in a single file passed
CheckThatAllPassed <- function(test_output) {
  ret <- TRUE
  for (test in test_output) {
    if (!CheckIfResultCorrect(test)) {
      ret <- FALSE
      break
    }
  }
  return (ret)
}

#Adds the points from a single test file to all the tests in the file
#returns points list, so that the modified points list is updated
AddPointsToAllTests <- function(test_output) {
  for (test in test_output) {
    if (!(points_for_all_tests %in% points[[test$test]])) {
      points[[test$test]] <- c(points[[test$test]], points_for_all_tests)
    }
  }
  return (points)
}

PrintResult <- function(status) {
  if (status) {
    print(paste(testName, ": FAIL", sep = ""))
    print(paste("   ", testMessage, sep = ""))
  } else {
    print(paste(testName, ": PASS", sep = ""))
  }
}

#Returns message from failed results
#Currently supports only results that used calls
MessageFromFailedResult <- function(result) {
  if (is.null(result$call)) return("")
  #language that failed the test. for example call expect_equal(1,2)
  language <- toString(result$call[[1]])
  return (paste(sep="", "Failed with call: ", language,"\n", result$message))
}

#Returns the points of a test or an empty vector if null
GetTestPoints <- function(testName) {
  if (is.null(points[[testName]])) {
    return(vector())
  } else {
    return(points[[testName]])
  }
}

CreateTestResult <- function(testStatus, testName, testMessage,
                             testPoints, backtrace) {
  testResult <- list(status=unbox(testStatus),
                     name=unbox(format(testName)),
                     message=unbox(testMessage),
                     backtrace=unbox(backtrace),
                     points=testPoints)
  return(testResult)
}

testthatOutput <- list()

#Lists all the files in the path beginning with "test" and ending in ".R"
testFiles <- list.files(path="tests/testthat", pattern = "test.*\\.R", full.names = T, recursive = FALSE)
for (testFile in testFiles) {
  testFileOutput <- test_file(testFile, reporter = "silent")
  #Modifies the points because they were added to all the tests.
  points <- AddPointsToAllTests(testFileOutput)
  #Adds the output from the tests in the file to the list
  testthatOutput <- c(testthatOutput, testFileOutput)
}

results = list()

for (test in testthatOutput) {
  testName <- test$test
  testPoints <- GetTestPoints(testName)
  testFailed <- FALSE
  testStatus <- "passed"
  testMessage <- ""
  for (result in test$results) {
    if (format(result) != "As expected") {
      testFailed <- TRUE
      testStatus <- "failed"
      testMessage <- paste(sep = "", testMessage, MessageFromFailedResult(result))
    }
  }
  PrintResult(testFailed)
  testResult <- CreateTestResult(testStatus, testName, testMessage,testPoints, "")
  #Add test result to results
  results[[length(results)+1]] <- testResult
}

#json utf-8 coded:
json <- enc2utf8(toJSON(results, pretty = FALSE))
json <- prettify(json)

#encode json to utf-8 and write file
write(json, ".results.json")
