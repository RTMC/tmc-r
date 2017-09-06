library('testthat')
output <- test_file('tests/testthat/testArithmetics.R', reporter="silent")
print(output)
