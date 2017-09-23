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

# test_that("RunTests works", {
#   runTests(simple_all_tests_pass_project_path)
# })

# test_that("PrintResult produces the right output", {
#   string1 <- format(.PrintResult("Testi1", "!", FALSE))
#   string2 <- format("Testi1: PASS")
#   expect_equal(string1, string2)
# })
