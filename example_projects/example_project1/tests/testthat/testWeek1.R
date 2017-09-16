library('testthat')
source('../../R/week1.R')

test_that("Variable 'x' has the correct value", {
    expect_equal(x, 13)
})
