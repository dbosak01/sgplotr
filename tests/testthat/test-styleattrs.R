


test_that("styleattrs1: styleattrs() parameters work.", {

  # backcolor = NULL, wallcolor = NULL,
  # datacolors = NULL, datacontrastcolors = NULL,
  # datafillpatterns, datalinepatterns = NULL,
  # datasymbols = NULL

  res <- sgplot(mtcars, titles = c("Title1", "Title2")) |>
    styleattrs(backcolor = "blue", wallcolor = "red",
               datacolors = c("grey", "blue", "red"),
               datacontrastcolors = "black",
               datafillpatterns = "stripes", datalinepatterns = "dots",
               datasymbols = "diamond")



  expect_equal(res$styleattrs[[1]]$backcolor, "blue")
  expect_equal(res$styleattrs[[1]]$wallcolor, "red")
  expect_equal(res$styleattrs[[1]]$datacolors, c("grey", "blue", "red"))
  expect_equal(res$styleattrs[[1]]$datacontrastcolors, "black")
  expect_equal(res$styleattrs[[1]]$datafillpatterns, "stripes")
  expect_equal(res$styleattrs[[1]]$datalinepatterns, "dots")
  expect_equal(res$styleattrs[[1]]$datasymbols, "diamond")


})
