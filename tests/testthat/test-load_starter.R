testthat::test_that("multiplication works", {
  starter <- load_starter()

  testthat::expect_type(starter, "data.frame")
})
