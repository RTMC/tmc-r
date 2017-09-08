library('testthat')

testthat_output <- test_dir('tests/testthat/', reporter="silent")

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
  } else {
    print(paste(test$test, ": PASS", sep = ""))
  }
}