#' Plot Quadratic Linear Mixed Model Treatment Contrasts
#'
#' Plots pairwise treatment contrasts over time from a fitted `quad` object.
#'
#' @param x An object of class `quad`.
#' @param ... Additional arguments passed to plotting functions.
#'
#' @return A `ggplot` object.
#'
#' @examples
#' data(melanoma1)
#' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' quad_obj <- quad(mel1)
#' plot(quad_obj)
#'
#' @export

plot.quad <- function(x, ...) {
  ggplot2::ggplot(
    x$contrast_df,
    ggplot2::aes(x = Time_month, y = estimate)
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
      x = "Time (months)",
      y = "Treatment contrast"
    ) +
    ggplot2::theme_bw()
}