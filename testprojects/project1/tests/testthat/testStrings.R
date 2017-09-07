library('testthat')
source('R/strings.R')

test_that("Constant string works", {
    expect_equal(constant_string(), "jono")
})
