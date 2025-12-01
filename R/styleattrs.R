
#' @title Assigns Style Attributes for a Plot
#' @description
#' The \code{styleattr} function allows you to override the template style settings
#' for a particular plot.  The function contains the most common style parameters
#' you may want to specify.
#' @details
#' Additional details...
#' @param plt The plot object to modify the style attributes for.
#' @param backcolor The color to use for the background.
#' @param wallcolor The color to use for the plot background.
#' @param datacolors The colors to use for the data.
#' @param datacontrastcolors The colors to use for the data contrast.
#' @param datafillpatterns The patterns to fill the data.
#' @param datalinepatterns The patterns to draw the lines.
#' @param datasymbols The symbols to use for points.
#' @returns The plot to which the style attributes are assigned.
#' @export
styleattrs <- function(plt, backcolor = NULL, wallcolor = NULL,
                      datacolors = NULL, datacontrastcolors = NULL,
                      datafillpatterns, datalinepatterns = NULL,
                      datasymbols = NULL) {



  # axisbreak = BRACKET, NOTCH, SLANTEDLEFT, SLANTEDRIGHT, SQIGGLE, SPARK, Z: Not sure
  # axisextent = FULL or DATA: Not sure I can do this


  # Parameter checks here



  # Create object
  ret <- structure(list(), class = c("styleattrs", "list"))


  ret$backcolor = backcolor
  ret$wallcolor = wallcolor
  ret$datacolors = datacolors
  ret$datacontrastcolors = datacontrastcolors
  ret$datafillpatterns = datafillpatterns
  ret$datalinepatterns = datalinepatterns
  ret$datasymbols = datasymbols


  # Can have more than one of these per plot
  plt$styleattrs[[length(plt$styleattrs) + 1]] <- ret


  return(plt)

}
