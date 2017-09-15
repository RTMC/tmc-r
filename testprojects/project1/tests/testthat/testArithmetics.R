library('testthat')
library('devtools')
sapply(list.files(pattern="[.]R$", path="R/", full.names=TRUE), source)
# install("../project1")
# library('project1')
# source('../../R/Arithmetics.R')

myTest <- function(desc, poings, code) {
  if(test_that(desc, code)) {
    return(poings)  
  }
}
print(myTest("Addition works", c("point1","point2"), {
  expect_equal(add(1, 2), 3)
  expect_equal(add(1, 2), 3.0)
  expect_equal(add(1, 4), 5)
}))

#Testing whether addition works.
# test_that("Addition works#[point1]", {
#   expect_equal(add(1, 2), 3)
#   expect_equal(add(1, 2), 3.0)
#   expect_equal(add(1, 4), 5)
# })

# test_that("Multiplication works#[point1, point2]", {
#   expect_equal(multiply(1, 2), 2)
#   expect_equal(multiply(2, 10), 20)
# })
# 
# test_that("Subtraction works#[point1, point2]", {
#     expect_equal(subtract(10, 2), 8)
#     expect_equal(subtract(0, 0), 0)
#     expect_equal(subtract(0, 4), -4)
# })
# 
# test_that("Division works#[point1, point2]", {
#     expect_equal(divide(10, 2), 5)
#     expect_equal(divide(1, 2), 0.5)
# })
