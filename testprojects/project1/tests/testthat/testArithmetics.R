library('testthat')

source("../../R/Arithmetics.R")

pointsForAllTests(c("r1"))

test("Addition works", c("r1.1","r.1.2"), {
  expect_equal(add(1, 2), 1)
  expect_equal(add(1, 2), 3.0)
  expect_equal(add(1, 4), 5)
})

test("Multiplication works", c("r1.3", "r1.4"), {
  expect_equal(multiply(1, 2), 2)
  expect_equal(multiply(2, 10), 20)
})

test("Subtraction works", c("r1.5"), {
  expect_equal(subtract(10, 2), 8)
  expect_equal(subtract(0, 0), 0)
  expect_equal(subtract(0, 4), -4)
})

test("Division works", c("r1.6"), {
  expect_equal(divide(10, 2), 5)
  expect_equal(divide(1, 2), 0.5)
})

test("Test with no points", c(), {
  expect_equal(1,1)
})
