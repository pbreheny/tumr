#' Plot the result of Exponential quadratic model
#'
#' Plots fitted treatment-specific quadratic growth curves or pairwise
#' treatment contrasts over time from a fitted \code{quad} object.
#'
#' @param x An object of class \code{"quad"}.
#' @param type Type of plot to produce. Either \code{"predict"} for fitted
#'   treatment-specific growth curves or \code{"contrast"} for pairwise
#'   treatment contrasts over time. Default is \code{"predict"}.
#' @param n_grid Number of time points used to construct the fitted curves.
#'   Default is 20.
#' @param ... Additional arguments passed to plotting functions.
#'
#' @return A \code{ggplot} object.
#'
#' @examples
#' data(melanoma1)
#' melanoma1$months <- melanoma1$Day / (365/12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' quad_obj <- quad(mel1)
#' plot(quad_obj, type = "predict")
#' plot(quad_obj, type = "contrast")
#'
#' @method plot quad
#' @export

plot.quad <- function(x,
                      type = c("predict", "contrast"),
                      n_grid = 20,
                      ...) {
  type <- match.arg(type)
  if (type == "predict") {
    time_grid <- seq(
      min(x$data$Time, na.rm = TRUE),
      max(x$data$Time, na.rm = TRUE),
      length.out = n_grid
    )
    pred <- ggeffects::predict_response(
      x$fit,
      terms = c("Time [all]", "Treatment"),
      type = "fixed",
      back_transform = FALSE)
    p <- plot(pred) + ggplot2::labs(
      x = "Time",
      y = "Tumor measurement (log scale)",
      color = "Treatment",
      fill = "Treatment"
    ) +
      ggplot2::theme_bw()
    return(p)
  }
  if (type == "contrast") {
    contrast_times <- sort(unique(x$contrast_df$Time))
    errorbar_width <- 0.1
    p <- ggplot2::ggplot(
      x$contrast_df,
      ggplot2::aes(
        x = Time,
        y = estimate
      )
    ) +
      ggplot2::geom_point(color = "black") +
      ggplot2::geom_errorbar(
        ggplot2::aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        width = errorbar_width,
        linewidth = 0.6,
        color = "black"
      ) +
      ggplot2::geom_hline(
        yintercept = 0,
        linetype = "dashed",
        color = "red"
      ) +
      ggplot2::facet_wrap(
        ~ contrast
      ) +
      ggplot2::labs(
        x = "Time",
        y = "Treatment contrast (log scale)"
      ) +
      ggplot2::theme_bw()
    return(p)
  }
}