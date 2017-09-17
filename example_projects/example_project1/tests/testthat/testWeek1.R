library('testthat')
source('../../R/week1.R')

help_A <- matrix(c(3, 5, 6, 1/2, sqrt(5), 16, 0, 2, 0),nrow = 3, ncol = 3, byrow = TRUE)

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
    expect_equal(v4_5, c(20, 10, 20, 30, 40))
})

test_that("Exercise 5 is correct", {
    t1 <- rep(0, 1, 50)
    t1[c(F, T)] <- 2
    expect_equal(v5_1, t1)
    expect_equal(sum5_1, 50)
    expect_equal(sum5_2, 80)
})

test_that("Excercise 6 is correct", {
    expect_equal(A, matrix(c(3, 5, 6, 1/2, sqrt(5), 16, 0, 2, 0),nrow = 3, ncol = 3, byrow = TRUE))
})

test_that("Excercise 6 is correct", {
  expect_equal(A, help_A)
})

test_that("Excercise 7 is correct", {
  expect_equal(B, c(1, 1, 0)%*%solve(help_A))
})

test_that("Excercise 8 is correct", {
  expect_equal(I_3, diag(c(1, 1, 1)))
  expect_equal(A_8, help_A)
})

test_that("Excercise 9 is correct", {
  expect_false(is_eq_matrix)
})

test_that("Excercise 10 is correct", {
  expect_true(number10 < 10)
  
  expect_true(dim(E_10)[1] == 4)
  expect_true(dim(E_10)[2] == 3)
})

test_that("Excercise 11 is correct", {
  M <- matrix(1:100, ncol=2)
  M[c(F, T)] <- NA
  expect_equal(C_11, M)
})

test_that("Excercise 12 is correct", {
  M <- matrix(1:100, ncol=2)
  M[c(F, T)] <- 0
  expect_equal(C_12, M)
})
