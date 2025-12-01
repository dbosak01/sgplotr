





# Base Render Function ----------------------------------------------------


#' @title Executes Rendering of a SGPlot Object
#' @description
#' Renders a plot to a file or the viewer.
#' @param plt The plot object to render. This parameter is required.
#' @param output_type An image type to output the plot to. Valid values
#' are "JPG", "JPEG", "SVG", "PNG", "BMP", "TIF", "TIFF" or NULL.  When NULL,
#' the function will render the plot interactively to the viewer.  Default is NULL.
#' @param file_path A path and file name to render the object to, if
#' an output file is requested. If no path is supplied,
#' a temporary file name will be generated.
#' @param height The height to of the output image.  Defaults to 480 pixels,
#' or the equivalent in the requested units.
#' @param width The width of the output image.  Defaults to 640 pixels, or the
#' equivalent in the requested units.
#' @param units The units associated with the image height and width. Defaults to
#' "px" meaning pixels.  Additional valid values are "in" for inches and "cm" for
#' centimeters.
#' @returns If an output file is requested, the path to the file. Otherwise,
#' a NULL.
#' @export
sgrender <- function(plt, output_type = NULL, file_path = NULL, height = NULL,
                     width = NULL, units = "px") {

  # Parameter checks
  if (!"sgplot" %in% class(plt) &
      !"sgpanel" %in% class(plt)) {

    stop("Object to render must be of class 'sgplot' or 'sgpanel'.")
  }

  if (!is.null(output_type)) {
    if (!toupper(output_type) %in% c("JPG", "JPEG", "SVG", "PNG", "BMP",
                                     "TIF", "TIFF")) {

      stop(paste0("Output type '", output_type, "' is invalid.\n",
                  "Valid values are: 'JPG', 'JPEG', 'SVG', 'PNG', 'BMP', 'TIF', 'TIFF'."))
    }
  }

  if (!is.null(units)) {
    if (!tolower(units) %in% c("in", "cm", "px")) {
      stop("Value for parameter 'units' is invalid.\nValid values are: 'in', 'cm', 'px'.")
    }
  } else {

    stop("Parameter 'units' cannot be NULL.")
  }

  if (!is.null(height)) {
    if (!is.numeric(height)) {
      stop("Parameter 'height' must be numeric.")
    }
  }

  if (!is.null(width)) {
    if (!is.numeric(width)) {
      stop("Parameter 'width' must be numeric.")
    }
  }


  # Create object
  ret <- structure(list(), class = c("sgrender", "list"))

  # Assign parameters
  ret$plot <- plt
  ret$output_type <- output_type
  ret$file_path <- file_path
  ret$height <- height
  ret$width <- width
  ret$units <- units

  # To avoid PDF file being created
  # Actually created on call to par()
  pdf(NULL)

  # Store current margins
  # May be changed in sub-functions
  op <- par()

  # Setup for output files
  if (!is.null(output_type)) {

    ret <- setup_output(ret)

  }

  # Generate the plot
  ret <- gen_plot(ret)

  # Turn off DC if necessary
  if (!is.null(output_type)) {
    dev.off()
  }

  # Restore margins
  # Remember to restore anything that can be changed in subroutines
  par(mar = op$mar, bg = op$bg)

  return(ret)
}


# If an output file is requested, turn on the appropriate function.
# Need adjustments to height, width, etc. for different output types.
# These adjustments should be invisible to the user.
#' @import grDevices
#' @import svglite
#' @noRd
setup_output <- function(sgr) {

  # To Do: Lot more parameters on these functions need to give the user
  # control over.  For now, just trying to get it to work.

  pth <- NULL


  # Default height and width values
  if (sgr$units == "px") {
    if (is.null(sgr$height)) {
      sgr$height <- 480
    }

    if (is.null(sgr$width)) {
      sgr$width <- 640
    }
  } else if (units == "in") {
    if (is.null(sgr$height)) {
      sgr$height <- 5
    }

    if (is.null(sgr$width)) {
      sgr$width <- 8.89
    }
  } else if (sgr$units == "cm") {
    if (is.null(sgr$height)) {
      sgr$height <- 12.7
    }

    if (is.null(sgr$width)) {
      sgr$ width <- 16.933
    }
  }

  # Default to temp file if needed
  if (is.null(sgr$file_path)) {

    pth <- tempfile(fileext = paste0(".", tolower(sgr$output_type)))
  } else {
    if (file.exists(sgr$file_path)) {

      file.remove(sgr$file_path)
    }
    pth <- sgr$file_path
  }

  # Create directory if needed
  pdir <- dirname(pth)
  if (!dir.exists(pdir)) {

    dir.create(pdir)
  }


  if (tolower(sgr$output_type) == "svg") {

    # SVG doesn't have px as a choice
    # Convert to inches if needed
    if (sgr$units == "px") {
      hgt <- sgr$height / 72
      wdth <- sgr$width / 72
    } else {
      hgt <- sgr$height
      wdth <- sgr$width
    }

    # if (capabilities("cairo")) {
    #   svg(filename = pth, height = hgt, width = wdth)
    # } else {
      svglite::svglite(pth, height = hgt, width = wdth)

    # }

  } else if (tolower(sgr$output_type) %in% c("jpg", "jpeg")) {

    jpeg(filename = pth, height = sgr$height, width = sgr$width, units = sgr$units)

  } else if (tolower(sgr$output_type) == "png") {

    png(filename = pth, height = sgr$height, width = sgr$width, units = sgr$units)

  } else if (tolower(sgr$output_type) == "bmp") {

    bmp(filename = pth, height = sgr$height, width = sgr$width, units = sgr$units)

  } else if (tolower(sgr$output_type) == "emf") {
    # May want to do someday.  Currently not working.
    devEMF::emf(file = pth, height = sgr$height, width = sgr$width, units = units)

  } else if (tolower(sgr$output_type) %in% c("tif", "tiff")) {

    tiff(filename = pth, height = sgr$height, width = sgr$width, units = sgr$units)

  }

  # Assign final path
  sgr$path <- pth


  return(sgr)

}


# Process commands which call rendering functions
#' @noRd
gen_plot <- function(sgr) {


  plt <- sgr$plot
  int <- TRUE
  if (!is.null(sgr$output_type)) {
    int <- FALSE
  }

  if (!is.null(plt$commands)) {
    for (cmd in plt$commands) {

      if ("sgvbar" %in% class(cmd)) {

        render_vbar(plt, cmd, int)
      }

    }
  }


  return(sgr)
}



# Render commands ---------------------------------------------------------

#' @importFrom stats aggregate
#' @import graphics
#' @noRd
render_vbar <- function(plt, cmd, interactive = FALSE) {

  # Get data
  dat <- plt$data

  # Get variables
  xvar <- cmd$var
  yvar <- cmd$response

  # Get stat
  st <- cmd$stat

  # Get titles
  ttls <- plt$titles

  # Create counter variable
  dat$cnt. <- 1

  # Get grouping variables
  grps <- cmd$group

  # Get group values
  grpvals <- NULL
  if (!is.null(grps)) {

     grpvals <- unique(dat[[grps]])
  }

  # Colors - for now
  if (length(grps) == 0) {
    cols <- "grey90"
  } else {
    cols <- c("#7B8CC3",   # blue-ish
              "#DC6E6C",   # red-ish
              "#5FB7A8",   # teal
              "#B08D52"    # brown/gold
              )

    cols <- cols[seq(1, length(grpvals))]
  }

  # Clustered display
  bsd <- FALSE
  if (!is.null(cmd$groupdisplay)) {
    if (tolower(cmd$groupdisplay) == "cluster") {
      bsd <- TRUE
    }
  }

  # No response, use the count variable, no statistic
  if (is.null(yvar)) {
    yvar <- "cnt."
  }

  if (is.null(st)) {
    st <- "sum"
  }

  byvars <- list(dat[[xvar]])
  grpvars <- NULL
  if (!is.null(grps)) {
    for (grp in grps) {
      byvars[[length(byvars) + 1]] <- dat[[grp]]
      grpvars[[length(grpvars) + 1]] <- paste0("GRP", length(grpvars) + 1)
    }
    mrg <- par()$mar
    mrg[1] <- mrg[1] + 1
    par(mar = mrg)
  }

  # Sum by variables
  sdat <- aggregate(dat[[yvar]], by = byvars, FUN = st)
  names(sdat) <- c("CAT", grpvars, "FREQ")

  # print("sdat")
  # print(sdat)

  # Get x names
  xnms <- unique(sdat$CAT)

  if (is.null(grps)) {
    ynms <- ""
    mdat <- sdat$FREQ
  } else {

    # Get y names
    ynms <- unique(sdat$GRP1)

    # Create matrix
    mdat <- sdat$FREQ
    dim(mdat) <- c(length(xnms), length(ynms))
    dimnames(mdat) <- list(xnms, ynms)

    # transpose
    mdat <- t(mdat)
  }

  # Create scale
 # yl <- c(0, max(sdat$FREQ))

  # print("mdat")
  # print(mdat)
  # print("xnms")
  # print(xnms)
  # print("xvar")
  # print(xvar)

  lgnd <- FALSE
  if (!is.null(grps)) {
    lgnd <- TRUE
  }

  # If no output file and not interactive, don't run.
  # Will be necessary to pass CRAN checks.
  if ((interactive & interactive()) |
      !interactive) {

    # Bar chart
    barplot(mdat,
            names.arg = xnms,
            main = ttls,
            beside = bsd,
            xlab = xvar,
            ylab = "Frequency",
          #  ylim = yl,
            col = cols,
            border = "grey20",
            legend.text = lgnd
          )

    # This will take some work
    # Comment out for now
    # Problem is getting it placed in the bottom margin
    # R doesn't do it that way by default
    # Will have to custom program it
    # if (!is.null(grps)) {
    #
    #   legend(
    #   )
  }

 # }

}
