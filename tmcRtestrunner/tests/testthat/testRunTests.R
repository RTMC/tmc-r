test_resources_dir <- paste(sep = "", getwd(), "/resources")

#projects for testing:
simple_all_tests_pass_project_path <- paste(sep = "", test_resources_dir, "/simple_all_tests_pass")

test_that("Test pass in simple_all_tests_pass", {
  results <- .RunTestsProject(simple_all_tests_pass_project_path)

  for (i in 1:3) {
    string <- format(results[[i]]$results[[1]])
    string2 <- "As expected"
    expect_equal(string, string2)
  }
})

#Tests that all exercise entrys store the point for all tests.
test_that("Tests that pass in simple_all_tests_pass all have the point for all tests", {
  results <- .RunTestsProject(simple_all_tests_pass_project_path)
  point <- "r1"
  for (i in 1:3) {
    vec1 <- results[[i]]$points
    expect_true(point %in% vec1)
  }
})

#Tests if the hidden function .AddPointsToTestOutput works as intended.
#It should add points to the dataframe based on which the result-file is created.
test_that("Points are added accordingly after calling .AddPointsToTestOutput", {
  testFileOutput <- test_file(paste(sep="", simple_all_tests_pass_project_path, "/tests/testthat/testMain.R"), reporter="silent")
  expect_equal(testFileOutput[[1]]$points, NULL)
  testFileOutput <- .AddPointsToTestOutput(testFileOutput)
  expect_false(is.null(testFileOutput[[1]]$points))
})

test_that("RunTests works as intended", {
  runTests(simple_all_tests_pass_project_path)
  expect_true(file.exists(paste(sep="",simple_all_tests_pass_project_path, "/.results.json")))
})



# test_that("RunTests works", {
#   runTests(simple_all_tests_pass_project_path)
# })

# test_that("PrintResult produces the right output", {
#   string1 <- format(.PrintResult("Testi1", "!", FALSE))
#   string2 <- format("Testi1: PASS")
#   expect_equal(string1, string2)
# })
