#

# sg_barplot_dev <- function() {
#
#   library(grDevices)
#
#   # Data
#   region <- c("Africa", "Asia", "Australia/Pacific",
#               "Europe", "North America", "South America")
#   freq   <- c(53, 46, 17, 47, 29, 12)
#
#
#   jpeg(filename = file.path(base_path, "output/test.jpg"),
#        width = 800, height = 600, units = "px", quality = 90)
#
#   # (Optional) give a little extra bottom margin for labels
#   par(mar = c(5, 4, 4, 2) + 0.1)
#
#   # Bar chart
#   barplot(freq,
#           names.arg = region,
#           main = "Olympic Countries by Region",
#           xlab = "Region",
#           ylab = "Frequency",
#           ylim = c(0, 55),
#           col = "grey90",
#           border = "grey20")
#
#
#
#   dev.off()
#
# }
#
#
#
# sg_stackedbar_dev <- function() {
#
#   ## Data -----------------------------------------------------------
#
#   regions <- c("Africa", "Asia", "Australia/Pacific",
#                "Europe", "North America", "South America")
#
#   # Population groups ("stack" categories)
#   pop_groups <- c("0 to <1M", "1M to <50M", "50M to <100M", ">= 100M")
#
#   # Matrix of counts — each row = population group, columns = regions
#   counts <- rbind(
#     "0 to <1M"     = c(6, 3, 14, 6, 14, 3),
#     "1M to <50M"   = c(42, 31, 2, 38, 0, 8),
#     "50M to <100M" = c(4, 7, 0, 4, 3, 0),
#     ">= 100M"      = c(2, 5, 1, 1, 2, 1)
#   )
#
#   ## Colors (similar to SAS) ----------------------------------------
#
#   cols <- c(
#     "0 to <1M"     = "#7B8CC3",   # blue-ish
#     "1M to <50M"   = "#DC6E6C",   # red-ish
#     "50M to <100M" = "#5FB7A8",   # teal
#     ">= 100M"      = "#B08D52"    # brown/gold
#   )
#
#   ## Plot -----------------------------------------------------------
#
#   par(mar = c(6, 5, 4, 2) + 0.1)
#
#   bp <- barplot(
#     counts,
#     beside = FALSE,           # Stacked bars
#     col = cols,
#     names.arg = regions,
#     ylim = c(0, 55),
#     main = "Olympic Countries by Region and Population Group",
#     xlab = "Region",
#     ylab = "Frequency",
#     legend.text = TRUE,
#     las = 2                  # rotate region labels
#   )
#
#   ## Legend ---------------------------------------------------------
#
#   legend(
#     "topright",
#     legend = pop_groups,
#     fill = cols,
#     title = "PopGroup",
#     bty = "n",
#     cex = 0.9
#   )
#
#
#
# }
#
#
# sg_clusteredbar_dev <- function() {
#
#   ## Data -----------------------------------------------------------
#
#   regions <- c("Africa", "Asia", "Australia/Pacific",
#                "Europe", "North America", "South America")
#
#   # Population groups shown in clusters
#   pop_groups <- c("0 to <1M", "1M to <50M", "50M to <100M", ">= 100M")
#
#   # Matrix of counts for each pop group × region
#   counts <- rbind(
#     "0 to <1M"     = c(6, 3, 14, 8, 14, 3),
#     "1M to <50M"   = c(42, 31, 3, 33, 13, 9),
#     "50M to <100M" = c(4, 6, 0, 5, 2, 1),
#     ">= 100M"      = c(1, 6, 0, 1, 3, 1)
#   )
#
#   ## Colors (matching your chart) ----------------------------------
#
#   cols <- c(
#     "0 to <1M"     = "#7B8CC3",
#     "1M to <50M"   = "#DC6E6C",
#     "50M to <100M" = "#5FB7A8",
#     ">= 100M"      = "#B08D52"
#   )
#
#   ## Plot -----------------------------------------------------------
#   # Allow drawing outside the plot region
#   par(mar = c(8, 5, 4, 2) + 0.1, xpd = TRUE)
#
#   bp <- barplot(
#     counts,
#     beside = TRUE,           # ← side-by-side bars instead of stacked
#     col = cols,
#     names.arg = regions,
#     ylim = c(0, 45),
#     main = "Olympic Countries by Region and Population Group",
#     xlab = "Region",
#     ylab = "Frequency",
#     las = 1
#   )
#
#   ## Legend ---------------------------------------------------------
#
#   # Orig
#   # legend(
#   #   "bottom",
#   #   legend = pop_groups,
#   #   fill = cols,
#   #  # title = "PopGroup",
#   #   bty = "n",
#   #   horiz = TRUE,
#   #   inset = c(0, -0.18),
#   #   xpd = TRUE
#   # )
#   #
#
#   # Mod
#   legend(
#     x = 9,
#     y = -5,
#     legend = pop_groups,
#     fill = cols,
#     title = "PopGroup",
#     title.adj = -.2,
#     bty = "n",
#     adj =  c(0, -1.5),
#     horiz = TRUE,
#    # inset = c(0, -0.18),
#     xpd = TRUE
#   )
#
#   # 1. Legend TITLE (placed manually)
#   text(
#     x = 8,        # left side of plot
#     y = -6.2,                  # adjust vertically as needed
#     labels = "PopGroup",
#     # adj = c(0, 0.5),          # left aligned
#     # cex = 0.9
#   )
#
#
#   # 1. Legend TITLE (placed manually)
#   # text(
#   #   x = par("usr")[1],        # left side of plot
#   #   y = -10,                  # adjust vertically as needed
#   #   labels = "PopGroup",
#   #   adj = c(0, 0.5),          # left aligned
#   #   cex = 0.9
#   # )
#
#   text(
#     x = 0,        # left side of plot
#     y = 10,                  # adjust vertically as needed
#     labels = "PopGroup",
#     # adj = c(0, 0.5),          # left aligned
#     # cex = 0.9
#   )
#
#
#   # 2. Legend KEYS (placed to the right of the title)
#   legend(
#     x = par("usr")[1] + 0.8,  # shift to the right of the title
#     y = -10,
#     legend = pop_groups,
#     fill = cols,
#     bty = "n",
#     horiz = TRUE,
#     x.intersp = 0.8,
#     cex = 0.9,
#     xpd = TRUE
#   )
#
#   par(xpd = FALSE)
#
#
# }
#
#
# sg_linechart_dev <- function() {
#
#
#   ## Data -----------------------------------------------------------
#
#   month <- 1:12
#
#   London <- c(47, 48, 52, 57, 63, 68, 72, 71, 66, 59, 52, 47)
#   Sochi  <- c(47, 48, 52, 59, 67, 75, 79, 82, 76, 66, 57, 50)
#   Rio    <- c(86, 87, 85, 82, 78, 75, 75, 76, 77, 79, 82, 85)
#
#   ## Colors & line styles ------------------------------------------
#
#   col_london <- "#4E6DB1"   # blue
#   col_sochi  <- "#C75E56"   # red
#   col_rio    <- "#2C8E77"   # teal
#
#   ## Set margins to match SAS-like layout --------------------------
#
#   par(mar = c(10, 5, 4, 5) + 0.1)
#
#   ## Empty plot setup ----------------------------------------------
#
#   plot(month, London,
#        type = "n",
#        ylim = c(30, 105),
#        xlab = "Month",
#        ylab = "High Temperatures (°F)",
#        main = "Average High Temperatures in Olympic Cities",
#        xaxt = "n")
#
#   axis(1, at = 1:12)
#
#   ## Light reference gridlines -------------------------------------
#
#   abline(h = c(32, 75), col = "gray80", lwd = 1)
#   text(12.2, 75, "75", pos = 4, cex = 0.9)
#   text(12.2, 32, "32", pos = 4, cex = 0.9)
#
#   ## Plot data lines & points --------------------------------------
#
#   lines(month, London, col = col_london, lwd = 2)
#   points(month, London, col = col_london, pch = 16, cex = 1)
#
#   lines(month, Sochi, col = col_sochi, lwd = 2)
#   points(month, Sochi, col = col_sochi, pch = 16, cex = 1)
#
#   lines(month, Rio, col = col_rio, lwd = 2)
#   points(month, Rio, col = col_rio, pch = 16, cex = 1)
#
#  legend("bottom",
#         legend = c("London", "Sochi", "Rio de Janeiro"),
#         col = c(col_london, col_sochi, col_rio),
#         lwd = 2,
#         pch = 16,
#         horiz = TRUE,
#         bty = "o",
#         box.lwd = .5,
#         box.col = "grey",
#         inset = c(0, -.3),
#         xpd = TRUE)
#
# }
#
#
#
# sg_bartext_dev <- function() {
#
#   ## ------------------------------------------------------------
#   ## Example data (replace with your real values if needed)
#   ## ------------------------------------------------------------
#
#   type  <- c("Hybrid", "SUV", "Sedan", "Sports", "Truck", "Wagon")
#   msrp  <- c(20000, 35000, 30000, 52000, 24000, 29000)
#   nvals <- c(3, 60, 262, 49, 24, 30)
#
#   engine <- c(1.6333, 3.92, 2.971, 3.4429, 4.0792, 2.77)
#   hp     <- c(92, 235.82, 201.66, 284.16, 224.83, 194)
#   weight <- c(2490.7, 4444.4, 3399.1, 3295.7, 4250.8, 3438.8)
#
#   ## ------------------------------------------------------------
#   ## Set up plot area
#   ## ------------------------------------------------------------
#
#   par(mar = c(6, 5, 6, 3) + 0.1)  # extra space for top & bottom text
#
#   bp <- barplot(
#     msrp,
#     names.arg = type,
#     ylim = c(0, 60000),
#     ylab = "MSRP (Mean)",
#     xlab = "Type",
#     col = "grey90",
#     border = "grey40",
#     las = 1
#   )
#
#   ## Add axis formatting (optional US dollar formatting)
#   axis(2, at = seq(0, 60000, 10000),
#        labels = paste0("$", format(seq(0, 60000, 10000), big.mark=",")))
#
#   ## ------------------------------------------------------------
#   ## Add N values under bars
#   ## ------------------------------------------------------------
#
#   text(bp, -3000, labels = nvals, xpd = TRUE)
#
#   text(mean(range(bp)), -8000, labels = "N", xpd = TRUE)  # global label
#
#   ## ------------------------------------------------------------
#   ## Add the three rows of summary values above bars
#   ## ------------------------------------------------------------
#
#   # Row 1: Engine Size (L)
#   text(bp, 62000, labels = sprintf("%.4g", engine), xpd = TRUE)
#
#   # Row 2: Horsepower
#   text(bp, 63500, labels = sprintf("%.4g", hp), xpd = TRUE)
#
#   # Row 3: Weight
#   text(bp, 65000, labels = sprintf("%.4g", weight), xpd = TRUE)
#
#   ## Row labels on far-left
#   text(min(bp) - 0.6, 62000, "Engine Size (L)", adj = 0, xpd = TRUE)
#   text(min(bp) - 0.6, 63500, "Horsepower",      adj = 0, xpd = TRUE)
#   text(min(bp) - 0.6, 65000, "Weight (LBS)",    adj = 0, xpd = TRUE)
#
#   ## ------------------------------------------------------------
#   ## Optional gridlines
#   ## ------------------------------------------------------------
#
#   abline(h = seq(0, 60000, 10000), col = "grey85", lwd = 1)
#
#
# }
#
#
# sg_scatter_dev <- function() {
#
#   ## Example data (replace with your own)
#   Height <- c(51.3, 56.3, 57.3, 57.5, 59.0, 59.8, 62.5,
#               62.8, 63.5, 64.3, 64.8, 65.3, 65.8, 66.5,
#               67.0, 69.0, 72.0)
#   Weight <- c(50, 76, 84, 82, 100, 84, 114,
#               102, 99, 128, 97, 112, 110, 130,
#               113, 120, 150)
#
#   ## Scatter plot
#   plot(Height, Weight,
#        xlab = "Height",
#        ylab = "Weight",
#        pch  = 1,               # open circles
#        col  = "royalblue3")    # outline color
#
#
#
#
#
# }
#
