pointsForAllTests <- function(points) {
  .GlobalEnv$points_for_all_tests <- points
}

test <- function(desc, points, code) {
  .GlobalEnv$points[[desc]] <- points
  test_that(desc, code)
}