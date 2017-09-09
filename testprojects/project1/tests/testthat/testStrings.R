library('testthat')
source('../../R/strings.R')

test_that("Constant string works#[point1, point2]", {
    expect_equal(constant_string(), "jono")
})
