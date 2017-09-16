library('testthat')
# source('/../../R/Example.R') #is not needed when using testthat.R to test package

#Test always succeeds
test_that("Example works", {
  expect_equal(returnsTrue(), TRUE)
})

#Test always fails
# test_that("Example works", {
#   expect_equal(returnsTrue(), FALSE)
# })