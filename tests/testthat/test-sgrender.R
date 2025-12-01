base_path <- paste0(getwd(),"/tests/testthat")

base_path <- tempdir()



dev <- FALSE


test_that("sgrender1: Parameters work.", {

  p <- sgplot(mtcars, titles = c("MTCARS by Cylinders")) |>
    sg_vbar("cyl")


  res <- sgrender(p, output_type = NULL, file_path = "here", height = 4,
                  width = 6, units = "in")


  expect_equal("sgplot" %in% class(res$plot), TRUE)
  expect_equal(res$file_path, "here")
  expect_equal(res$height, 4)
  expect_equal(res$width, 6)
  expect_equal(res$units, "in")
  expect_equal(is.null(res$output_type), TRUE)


  expect_error(sgrender(p, output_type = "bork"))
  expect_error(sgrender(p, output_type = "jpg", units = "bork"))
  expect_error(sgrender(p, output_type = "jpg", units = NULL))
  expect_error(sgrender(p, output_type = "jpg", height = "two"))
  expect_error(sgrender(p, output_type = "jpg", width = "three"))

})

test_that("sgrender2: Render output types works.", {


  # Single variable only
  p <- sgplot(mtcars, titles = c("MTCARS by Cylinders")) |>
    sg_vbar("cyl")

  # JPG
  if (capabilities("jpeg")) {
    fp <- file.path(base_path, "output/test.jpg")

    if (file.exists(fp)) {
      file.remove(fp)
    }

    res <- sgrender(p, output_type = "jpg", file_path = fp)

    expect_equal(file.exists(res$path), TRUE)
  }

  # BMP
  # Not sure what the test for capabilities is for this
  fp <- file.path(base_path, "output/test.bmp")

  if (file.exists(fp)) {
    file.remove(fp)
  }

  res <- sgrender(p, output_type = "bmp", file_path = fp)

  expect_equal(file.exists(res$path), TRUE)

  # PNG
  if (capabilities("png")) {
    fp <- file.path(base_path, "output/test.png")

    if (file.exists(fp)) {
      file.remove(fp)
    }

    res <- sgrender(p, output_type = "png", file_path = fp)

    expect_equal(file.exists(res$path), TRUE)
  }

  # SVG
  if (capabilities("cairo")) {
    fp <- file.path(base_path, "output/test.svg")

    if (file.exists(fp)) {
      file.remove(fp)
    }

    res <- sgrender(p, output_type = "svg", file_path = fp)

    expect_equal(file.exists(res$path), TRUE)

  }

  # TIF
  if (capabilities("tiff")) {
    fp <- file.path(base_path, "output/test.tif")

    if (file.exists(fp)) {
      file.remove(fp)
    }

    res <- sgrender(p, output_type = "tif", file_path = fp)

    expect_equal(file.exists(res$path), TRUE)
  }

  # Ensure at least one test
  expect_equal(TRUE, TRUE)
})







# test_that("sgrender3: Render hbar works.", {
#
#   dat <- mtcars
#   dat$Group <- c(rep("A", 16), rep("B", 16))
#
#
#   # Single variable only
#   p <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
#     sg_vbar("cyl")
#
#
#   res1 <- sgrender(p)
#
#
#   # Single variable only
#   p2 <- sgplot(iris, titles = c("IRIS by Species")) |>
#     sg_vbar("Species")
#
#
#   res2 <- sgrender(p2)
#
#
#   # Grouping variable, stacked bar
#   p3 <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
#     sg_vbar("cyl", group = "Group")
#
#
#   res3 <- sgrender(p3)
#
#
#
#   # Grouping variable, clustered bar
#   p4 <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
#     sg_vbar("cyl", group = "Group", groupdisplay = "cluster")
#
#
#   res4 <- sgrender(p4)
#
#
#   # No errors
#   expect_equal(TRUE, TRUE)
#
# })


