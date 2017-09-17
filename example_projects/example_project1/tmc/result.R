library('testthat')
library('jsonlite')

#declaring variables to global environment that for example helperTMC.R can use
points <- list()
points_for_all_tests <- list

#TODO: run all tests with test_file from tests/testthat folder
testthat_output <- test_file('tests/testthat/testArithmetics.R', reporter="silent")

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
  test_name <- test$test
  test_points <- points[[test_name]]
  
  test_failed <- FALSE
  test_failures <- c()
<<<<<<< HEAD
  
=======

  #For single tests, we mark whether it passed or failed.
>>>>>>> real-exe
  for (result in test$results) {
    if (format(result) != "As expected") {
      test_failed <- TRUE
      test_failures <- c(test_failures, format(result))
    }
  }

  #If the test failed, we produce a corresponding output
  if (test_failed) {
<<<<<<< HEAD
=======
    test_description <- strsplit(format(test$test), "#")
    points <- points_compiler(test_description)
    test_name <- test_description[[1]][1]

>>>>>>> real-exe
    print(paste(test_name, ": FAIL", sep = ""))
    print(paste("   ", test_failures, sep = ""))

    test_result <- list(backtrace=list(),
        status=unbox("failed"),
        name=unbox(format(test_name)),
        message=unbox(""),
<<<<<<< HEAD
        points=list())
  } else {
=======
        points=points)

  }
  #If the test passed, we produce a corresponding output.
  else {
    test_description <- strsplit(format(test$test), "#")

    points <- points_compiler(test_description)

    test_name <- test_description[[1]][1]

>>>>>>> real-exe
    print(paste(test_name, ": PASS", sep = ""))
    
    test_result <- list(backtrace=list(),
        status=unbox("passed"),
        name=unbox(format(test_name)),
        message=unbox(""),
<<<<<<< HEAD
        points=test_points)
=======
        points=points)
>>>>>>> real-exe
  }
  results[[length(results)+1]] <- test_result
}

#json utf-8 coded:
json <- enc2utf8(toJSON(results, pretty = FALSE))
json <- prettify(json)

#encode json to utf-8 and write file
write(json, ".results.json")
