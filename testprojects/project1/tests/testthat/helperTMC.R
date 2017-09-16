pointsForAllTests <- function(points) {
  print( dirname(sys.frame(1)$ofile))
}

test <- function(desc, poings, code) {
  
  if(test_that(desc, code)) {
    return(poings)  
  }
}