# Runs the tests from project directory and writes results JSON to the root of the project
# as .tmc_results.json.
#
# Args:
#  project_path: The absolute path to the root of the project being tested.
#  print: If TRUE, prints results; if not, not. DEFAULT is FALSE.
#
runTests <- function(project_path, print=FALSE) {
  library('testthat')
  library('jsonlite')

  tmcrtestrunner_project_path <- getwd()

  results <- GetTestResults(project_path, print)
  .WriteJson(results)

  setwd(tmcrtestrunner_project_path)

}

GetTestResults <- function(project_path, print = FALSE) {

  setwd(project_path)
  #declaring variables to global environment that for example helperTMC.R can use
  points <- list()
  points_for_all_tests <- list()

  testthatOutput <- list()

  #Lists all the files in the path beginning with "test" and ending in ".R"
  testFiles <- list.files(path="tests/testthat", pattern = "test.*\\.R", full.names = T, recursive = FALSE)
  print(getwd())
  for (testFile in testFiles) {
    testFileOutput <- test_file(testFile, reporter = "silent")
    #Modifies the points because they were added to all the tests.
    points <- .AddPointsToAllTests(testFileOutput)
    #Adds the output from the tests in the file to the list
    testthatOutput <- c(testthatOutput, testFileOutput)
  }

  return(testthatOutput)

}

.WriteJson <- function(results) {
    #json utf-8 coded:
    json <- enc2utf8(toJSON(results, pretty = FALSE))
    json <- prettify(json)
    #encode json to utf-8 and write file
    write(json, ".results.json")
}

.CreateResults <- function(testthatOutput) {
    results = list()
    for (test in testthatOutput) {
      testName <- test$test
      testPoints <- .GetTestPoints(testName)
      testFailed <- FALSE
      testStatus <- "passed"
      testMessage <- ""
      for (result in test$results) {
        if (format(result) != "As expected") {
          testFailed <- TRUE
          testStatus <- "failed"
          testMessage <- paste(sep = "", testMessage, .MessageFromFailedResult(result))
        }
      }
      .PrintResult(testName, testMessage, testFailed)
      testResult <- .CreateTestResult(testStatus, testName, testMessage,testPoints, "")
      #Add test result to results
      results[[length(results)+1]] <- testResult
    }
    return (results)
  }

#Checks if a single test passed
.CheckIfResultCorrect <- function(test) {
  ret <- TRUE
  for (result in test$results) {
    if (format(result) != "As expected") {
      ret <- FALSE
      break
    }
  }
  return (ret)
}

#Checks whether all the tests in a single file passed
.CheckThatAllPassed <- function(test_output) {
  ret <- TRUE
  for (test in test_output) {
    if (!.CheckIfResultCorrect(test)) {
      ret <- FALSE
      break
    }
  }
  return (ret)
}

#Adds the points from a single test file to all the tests in the file
#returns points list, so that the modified points list is updated
.AddPointsToAllTests <- function(test_output) {
  for (test in test_output) {
    if (!(points_for_all_tests %in% points[[test$test]])) {
      points[[test$test]] <- c(points[[test$test]], points_for_all_tests)
    }
  }
  return (points)
}

.PrintResult <- function(name, message, failed) {
  if (failed) {
    print(paste(name, ": FAIL", sep = ""))
    print(paste("   ", message, sep = ""))
  } else {
    print(paste(name, ": PASS", sep = ""))
  }
}

#Returns message from failed results
#Currently supports only results that used calls
.MessageFromFailedResult <- function(result) {
  if (is.null(result$call)) {
    return("")
  }
  #language that failed the test. for example call expect_equal(1,2)
  language <- toString(result$call[[1]])
  return (paste(sep="", "Failed with call: ", language,"\n", result$message))
}

#Returns the points of a test or an empty vector if null
.GetTestPoints <- function(testName) {
  if (is.null(points[[testName]])) {
    return(vector())
  } else {
    return(points[[testName]])
  }
}

.CreateTestResult <- function(testStatus, testName, testMessage,
                             testPoints, backtrace) {
  testResult <- list(status=unbox(testStatus),
                     name=unbox(format(testName)),
                     message=unbox(testMessage),
                     backtrace=unbox(backtrace),
                     points=testPoints)
  return(testResult)
}

DummyFunction <- function() {
  return(TRUE)
}

.hidden_function <- function() {
  return(T)
}

Dummy2 <- function() {
  return(T)
}

Dummy3 <- function() {
  return(F)
}
