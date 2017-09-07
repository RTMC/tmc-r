library('testthat')


test_that("Constant string works", {
    expect_equal(constant_string(), "jono")
})
