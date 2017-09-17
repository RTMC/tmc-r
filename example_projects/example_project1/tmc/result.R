library('testthat')
library('jsonlite')

testthat_output <- test_dir('tests/testthat/', reporter="silent")

results = list()

#Compiles the list of points from the test description
points_compiler <- function(desc) {
    points_assoc <- desc[[1]][2]
    points_assoc <- gsub("\\[|\\]", "", points_assoc)
    points_assoc <- gsub(",", "", points_assoc)
    points_assoc <- as.list(lapply(strsplit(points_assoc, '\\s+')[[1]], unbox))
}

#We go through the test output
for (test in testthat_output) {
  test_failed <- FALSE
  test_failures <- c()

  #For single tests, we mark whether it passed or failed.
  for (result in test$results) {
    if (format(result) != "As expected") {
      test_failed <- TRUE
      test_failures <- c(test_failures, format(result))
    }
  }

  #If the test failed, we produce a corresponding output
  if (test_failed) {
    test_description <- strsplit(format(test$test), "#")
    points <- points_compiler(test_description)
    test_name <- test_description[[1]][1]

    print(paste(test_name, ": FAIL", sep = ""))
    print(paste("   ", test_failures, sep = ""))

    test_result <- list(backtrace=list(),
        status=unbox("failed"),
        name=unbox(format(test_name)),
        message=unbox(""),
        points=points)

  }
  #If the test passed, we produce a corresponding output.
  else {
    test_description <- strsplit(format(test$test), "#")

    points <- points_compiler(test_description)

    test_name <- test_description[[1]][1]

    print(paste(test_name, ": PASS", sep = ""))
    test_result <- list(backtrace=list(),
        status=unbox("passed"),
        name=unbox(format(test_name)),
        message=unbox(""),
        points=points)
  }
  results[[length(results)+1]] <- test_result
}

#json utf-8 coded:
json <- enc2utf8(toJSON(results, pretty = FALSE))
json <- prettify(json)

#encode json to utf-8 and write file
write(json, ".results.json")
