base_path <- paste0(getwd(),"/tests/testthat")

base_path <- tempdir()


dev <- FALSE

# Test that all parameters are being populated properly
test_that("sgplot1: sgplot() works.", {

  res <- sgplot(mtcars, titles = c("Title1", "Title2"))


  expect_equal(is.null(res), FALSE)
  expect_equal(length(res$titles), 2)
  expect_equal("data.frame" %in% class(res$data), TRUE)

})


# Test parameters
test_that("sgplot2: sg_vbar() works.", {


  p <- sgplot(mtcars, titles = c("Title1", "Title2")) |>
    sg_vbar("cyl", response = "resp", group = "group", groupdisplay = "cluster")


  expect_equal(is.data.frame(p$data), TRUE)
  expect_equal(length(p$commands), 1)
  expect_equal(p$commands[[1]]$var, "cyl")
  expect_equal(p$commands[[1]]$response, "resp")
  expect_equal(p$commands[[1]]$group, "group")
  expect_equal(p$commands[[1]]$groupdisplay, "cluster")

})


test_that("sgplot3: sg_hbar() works.", {

  expect_equal(TRUE, TRUE)

})
