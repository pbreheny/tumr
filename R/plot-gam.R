#' Plot of GAM Fit
#'
#' Plots estimated pairwise treatment contrasts over time with 95\% confidence
#' intervals, faceted by group pair.
#'
#' @param x An object of class \code{"tumr_gam"} returned by \code{\link{gam}}.
#' @param ... Currently ignored.
#'
#' @return A \code{ggplot} object.
#' @method plot tumr_gam
#' @export

plot.tumr_gam <- function(x, ...) {
  ggplot2::ggplot(
    x$contrast_df,
    ggplot2::aes(x = Time, y = estimate)
  ) +
    ggplot2::geom_point() +
    ggplot2::geom_errorbar(
      ggplot2::aes(
        ymin = lower.CL,
        ymax = upper.CL
      ),
      width = 0.1
    ) +
    ggplot2::geom_hline(
      yintercept = 0,
      linetype = "dashed"
    ) +
    ggplot2::facet_wrap(~ contrast) +
    ggplot2::labs(
      x = x$relevant_info$Time,
      y = "Treatment contrast on log scale"
    ) +
    ggplot2::theme_bw()
}