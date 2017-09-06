
#FOR SOME REASON, THE RELATIVE WORKING DIRECTORY CHANGES UNEXPECTEDLY
source("../../R/Arithmetics.R")
library('testthat')

test_that("Addition works", {
  expect_equal(add(1, 2), 3)
  expect_equal(add(1, 2), 3.0)
  expect_equal(add(1, 4), 5)
})

test_that("Multiplication works", {
  expect_equal(multiply(1, 2), 2)
  
})
