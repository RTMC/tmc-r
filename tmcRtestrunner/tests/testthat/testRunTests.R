test_that("Dummy test before real tests.", {
  expect_true(DummyFunction())
})

test_that("Empty test works", {
  expect_true(runTests())
})

test_that("Dummy2 works", {
  expect_true(Dummy2())
})

test_that("Dummy3 works", {
  expect_false(Dummy3())
})
