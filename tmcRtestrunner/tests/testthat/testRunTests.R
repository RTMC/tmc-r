project_path <- find_root(has_file("DESCRIPTION"))
project_path <- dirname(project_path)
path_to_example1 <- paste(sep = "", project_path, "/example_projects/example_project1")
path_to_json <- paste(set="", path_to_example1, "/.results.json")


test_that("Dummy test before real tests.", {
  expect_true(DummyFunction())
})

test_that("Dummy2 works", {
  expect_true(Dummy2())
})

test_that("Dummy3 works", {
  expect_false(Dummy3())
})

test_that("Hidden functions work", {
  expect_true(.hidden_function())
})

test_that("GetTestResults works as intended", {
  results <- GetTestResults(path_to_example1)
  string <- format(results[[1]]$results[[1]])
  string2 <- "As expected"
})

test_that("RunTests works", {
  runTests(path_to_example1)
})

test_that("PrintResult produces the right output", {
  string1 <- format(.PrintResult("Testi1", "!", FALSE))
  string2 <- format("Testi1: PASS")
  expect_equal(string1, string2)
})
