library('testthat')

#We can define sources in the environment already in this file.
source('R/Arithmetics.R')


output <- test_file('tests/testthat/testArithmetics.R', reporter="silent")
print(output)
