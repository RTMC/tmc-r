path <- file.path(getwd())
path <- dirname(dirname(dirname(path)))
path_to_example1 <- paste(sep = "", path, "/example_projects/example_project1")
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

test_that("Tests pass", {
  expect_true(T)
})
