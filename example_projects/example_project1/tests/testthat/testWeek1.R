library('testthat')
source('../../R/week1.R')

test_that("Exercise 1 is correct", {
    expect_equal(a1, 14)
    expect_equal(b1, 70)
    expect_equal(c1, 343000)
    expect_true(abs(e1-1096.63) < 0.1)
    expect_true(abs(f1 - 0.7920019) < 0.1)
    expect_true(abs(res1 - 344167.4) < 0.1)
})

test_that("Exercise 2 is correct", {
    expect_equal(a2, 2)
})

test_that("Exercise 3 is correct", {
    expect_equal(a3, 9)
})

test_that("Exercise 4 is correct", {
    expect_equal(v4_1, c(20, 5, -2, 3, 47))
    expect_equal(v4_2, c(0:20)*5)
    expect_equal(v4_3, c(c(20, 5, -2, 3, 47), seq(0, 100, 5)))
    expect_equal(v4_4, c(20, 5, 47, 5, 10, 15, 20, 25, 30, 35, 40, 45))

})
