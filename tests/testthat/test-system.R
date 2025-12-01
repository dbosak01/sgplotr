base_path <- paste0(getwd(),"/tests/testthat")

base_path <- tempdir()


dat <- read.table(header = TRUE, text = '
  Region Eyes Hair Count
  1 blue  fair   23
  1 blue  dark   11
  1 green medium 18
  1 brown red     5
  1 brown black   3
  2 blue  medium 44
  2 green fair   50
  2 green dark   23
  2 brown medium 53
  1 blue  red     7
  1 green fair   19
  1 green dark   14
  1 brown medium 41
  2 blue  fair   46
  2 blue  dark   40
  2 green red    31
  2 brown fair   56
  2 brown dark   54
  1 blue  medium 24
  1 green red     7
  1 brown fair   34
  1 brown dark   40
  2 blue  red    21
  2 blue  black   6
  2 green medium 37
  2 brown red    42
  2 brown black  13
  ')



prt2 <- read.table(header = TRUE, text = '
      sex internship enrollment count  group
  1  boys        yes        yes    35      1
  2  boys         no        yes    14      1
  3 girls        yes        yes    32      1
  4 girls         no        yes    53      1
  5  boys        yes         no    29      2
  6  boys         no         no    27      2
  7 girls        yes         no    10      2
  8 girls         no         no    23      2')




dev <- FALSE

# These tests should be run interactively so you can look at the output
# and make sure everything is coming out OK.

test_that("system1: Render vbar no response works.", {

  dat <- mtcars
  dat$Group <- c(rep("A", 16), rep("B", 16))


  # Single variable only
  p <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
    sg_vbar("cyl")


  res1 <- sgrender(p)


  # Single variable only
  p2 <- sgplot(iris, titles = c("IRIS by Species")) |>
    sg_vbar("Species")


  res2 <- sgrender(p2)


  # Grouping variable, stacked bar
  p3 <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
    sg_vbar("cyl", group = "Group")


  res3 <- sgrender(p3)



  # Grouping variable, clustered bar
  p4 <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
    sg_vbar("cyl", group = "Group", groupdisplay = "cluster")


  res4 <- sgrender(p4)


  # Grouping variable, clustered bar
  p5 <- sgplot(dat, titles = c("MTCARS by Cylinders")) |>
    sg_vbar("cyl", group = "Group", groupdisplay = "cluster")


  res5 <- sgrender(p5)


  # No errors
  expect_equal(TRUE, TRUE)

})


test_that("system2: Render vbar response works.", {

  # Response variable
  dt <- prt2[prt2$enrollment == 'yes' & prt2$internship == 'yes', ]
  p1 <- sgplot(dt, titles = c("Students by Sex")) |>
    sg_vbar("sex", response = "count")


  res1 <- sgrender(p1)

  # Response variable with group
  dt <- prt2[prt2$internship == 'yes', ]
  p2 <- sgplot(dt, titles = c("Students by Sex and Enrollment")) |>
    sg_vbar("sex", response = "count", group = "enrollment")


  res2 <- sgrender(p2)

  # Response variable with group clustered
  dt <- prt2[prt2$internship == 'yes', ]
  p3 <- sgplot(dt, titles = c("Students by Sex and Enrollment")) |>
    sg_vbar("sex", response = "count", group = "enrollment", groupdisplay = "cluster")


  res3 <- sgrender(p3)

  # No errors
  expect_equal(TRUE, TRUE)

})


test_that("system3: Render vbar options works.", {

  # Response variable
  dt <- prt2[prt2$enrollment == 'yes' & prt2$internship == 'yes', ]
  p1 <- sgplot(dt, titles = c("Students by Sex")) |>
    sg_vbar("sex", response = "count")


  res1 <- sgrender(p1)

  # Response variable with group
  dt <- prt2[prt2$internship == 'yes', ]
  p2 <- sgplot(dt, titles = c("Students by Sex and Enrollment")) |>
    sg_vbar("sex", response = "count", group = "enrollment")


  res2 <- sgrender(p2)

  # Response variable with group clustered
  dt <- prt2[prt2$internship == 'yes', ]
  p3 <- sgplot(dt, titles = c("Students by Sex and Enrollment")) |>
    sg_vbar("sex", response = "count", group = "enrollment", groupdisplay = "cluster")


  res3 <- sgrender(p3)

  # No errors
  expect_equal(TRUE, TRUE)

})


