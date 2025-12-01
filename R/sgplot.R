


# Base SGPlot Object ------------------------------------------------------




#' @title Initializes an SGPlot Object
#' @description
#' The \code{sgplot} function creates an object of class "sgplot",
#' which forms the basis for a new plot.
#' @param dat The data to use for this plot. This parameter is required.
#' @param titles A vector of optional titles.
#' @param theme An optional theme to use for this plot.
#' @export
sgplot <- function(dat, titles = NULL, theme = NULL) {

  if (is.null(dat)) {
    stop("Data parameter 'dat' missing or invalid.")

  }

  if (!"data.frame" %in% class(dat)) {
    stop("Data parameter 'dat' must be derived from a data frame.")

  }

  ret <- structure(list(), class = c("sgplot", "list"))

  ret$data <- dat
  ret$titles <- titles
  ret$theme <- theme
  ret$commands <- list()
  ret$styleattrs <- list()

  return(ret)
}




# Base SGPanel Object -----------------------------------------------------


#' @title Initializes an SGPanel Object
#' @param dat The data to use for this plot. This parameter is required.
#' @param titles A vector of optional titles.
#' @param theme An optional theme to use for this plot.
#' @export
sgpanel <- function(dat, titles = NULL, theme = NULL) {

  if (is.null(dat)) {
    stop("Data parameter 'dat' missing or invalid.")

  }

}




# SG Commands --------------------------------------------------------------


#' @title Request a Vertical Bar Plot
#' @param plt The base plotting object.  Value values are an \code{sgplot}
#' or \code{sgpanel} object.
#' @param var The variable to use for the X axis.
#' @param response The variable to use for the Y axis.
#' @param stat The statistic to use for the bar height calculation. This parameter
#' @param group The variable to group by.
#' @param groupdisplay Indicates how to display the grouping variable.
#' is optional.  If not supplied, the raw value of the response variable will
#' be used.
sg_vbar <- function(plt, var, response = NULL, stat = NULL,
                    group = NULL, groupdisplay = NULL) {

  ret <- structure(list(), class = c("sgvbar", "sgcmd", "list"))

  ret$var <- var
  ret$response <- response
  ret$stat <- stat
  ret$group <- group
  ret$groupdisplay <- groupdisplay

  plt$commands[[length(plt$commands) + 1]] <- ret

  return(plt)

}
