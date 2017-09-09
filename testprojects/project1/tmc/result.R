library('testthat')
library('jsonlite')

testthat_output <- test_dir('tests/testthat/', reporter="silent")

#Create new dataframe with one empty row and five columns.
results.frame = as.data.frame(matrix(ncol=5, nrow=1))

#Names of the columns
names(results.frame) = c("backtrace", "status", "name", "message", "points")

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
    results.frame = rbind(results.frame, c("[]", "passed", format(test$test), "läpi meni", "1"))
  }
}

#This is a hack. For some reason there are factor-problems constructing the data frame is not done as follows.
results.frame <- results.frame[-1,]

json <-toJSON(results.frame, pretty = TRUE)
write_json(json, "results.json")
