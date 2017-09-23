test_resources_dir <- paste(sep = "", getwd(), "/resources")

#projects for testing:
simple_all_tests_pass_project_path <- paste(sep = "", test_resources_dir, "/simple_all_tests_pass")

test_that("GetTestResults works as intended", {
  results <- .GetTestResults(simple_all_tests_pass_project_path)
  string <- format(results[[1]]$results[[1]])
  string2 <- "As expected"
})

test_that("RunTests works", {
  runTests(simple_all_tests_pass_project_path)
})

test_that("PrintResult produces the right output", {
  string1 <- format(.PrintResult("Testi1", "!", FALSE))
  string2 <- format("Testi1: PASS")
  expect_equal(string1, string2)
})
