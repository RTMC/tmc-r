library('testthat')
library('jsonlite')

#declaring variables to global environment that for example helperTMC.R can use
points <- list()
points_for_all_tests <- list

#TODO: run all tests with test_file from tests/testthat folder
testthat_output <- test_file('tests/testthat/testArithmetics.R', reporter="silent")

results = list()

for (test in testthat_output) {
  test_name <- test$test
  test_points <- points[[test_name]]

  test_failed <- FALSE
  test_failures <- c()

  for (result in test$results) {
    if (format(result) != "As expected") {
      test_failed <- TRUE
      test_failures <- c(test_failures, format(result))
    }
  }

  if (test_failed) {
    print(paste(test_name, ": FAIL", sep = ""))
    print(paste("   ", test_failures, sep = ""))

    test_result <- list(backtrace=list(),
        status=unbox("failed"),
        name=unbox(format(test_name)),
        message=unbox(""),
        points=list())
  } else {
    print(paste(test_name, ": PASS", sep = ""))

    test_result <- list(backtrace=list(),
        status=unbox("passed"),
        name=unbox(format(test_name)),
        message=unbox(""),
        points=test_points)
  }
  results[[length(results)+1]] <- test_result
}

#json utf-8 coded:
json <- enc2utf8(toJSON(results, pretty = FALSE))
json <- prettify(json)

#encode json to utf-8 and write file
write(json, ".results.json")
