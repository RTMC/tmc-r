library('testthat')
library('jsonlite')

testthat_output <- test_dir('tests/testthat/', reporter="silent")

results = c()

for (test in testthat_output) {
  test_failed <- FALSE
  test_failures <- c()
  for (result in test$results) {
    if (format(result) != "As expected") {
      test_failed <- TRUE
      test_failures <- c(test_failures, format(result))
    }
  }

  if (test_failed) {
    print(paste(test$test, ": FAIL", sep = ""))
    print(paste("   ", test_failures, sep = ""))
    test_result <- list(backtrace=list(), status=unbox("failed"), name=unbox(format(test$test)), message=unbox(""), points=list())
  } else {
    print(paste(test$test, ": PASS", sep = ""))
    test_result <- list(backtrace=list(), status=unbox("passed"), name=unbox(format(test$test)), message=unbox(""), points=list(unbox("point1"), unbox("point2")))
  }
  
  results <- c(results, test_result)
}

#currently encoding is not utf-8... TODO: fix this
json <-toJSON(results, pretty = TRUE)
write_json(json, ".results.json")
