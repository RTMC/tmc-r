library('testthat')

#We can define sources in the environment already in this file.
source('R/arithmetics.R')
source('R/strings.R')


output <- test_dir('tests/testthat/', reporter="silent")
print(output)
