#' Creates plots for a bhm object
#'
#' Produces interval plots for treatment-specific slopes and slope contrasts
#' based on the posterior summaries returned by \code{summary()}.
#'
#' @param x A \code{bhm} object returned by \code{bhm()}.
#' @param ... Further arguments passed to or from other methods (currently unused).
#'
#' @return Invisibly returns a list with two ggplot objects:
#' \code{slope_each_plot} and \code{slope_diff_plot}.
#'
#' @examples
#' data("melanoma1")
#' fit <- bhm(melanoma1)
#' plot(fit)
#'
#' @export


plot.bhm <- function(x, ...) {

  emm_sum <- summary(x)

  slope_plot <- emm_sum$slope_each
  p1 <- ggplot2::ggplot(slope_plot, ggplot2::aes(y = .data$treatment)) +
    ggplot2::geom_segment(
      ggplot2::aes(x = .data$q5, xend = .data$q95, yend = .data$treatment),
      linewidth = 6,
      color = "#b6dfe2"
    ) +
    ggplot2::geom_point(
      ggplot2::aes(x = .data$mean),
      shape = 18,
      size = 4,
      color = "black"
    ) +
    ggplot2::labs(
      x = "Day.trend (posterior mean with 90% credible interval)",
      y = "Treatment"
    ) +
    ggplot2::theme_minimal(base_size = 14)

  slope_diff <- emm_sum$slope_diff
  p2 <- ggplot2::ggplot(slope_diff, ggplot2::aes(y = .data$contrast)) +
    ggplot2::geom_segment(
      ggplot2::aes(x = .data$q5, xend = .data$q95, yend = .data$contrast),
      linewidth = 6,
      color = "#b6dfe2"
    ) +
    ggplot2::geom_point(
      ggplot2::aes(x = .data$mean),
      shape = 18,
      size = 4,
      color = "black"
    ) +
    ggplot2::labs(
      x = "Day.trend (posterior mean with 90% credible interval)",
      y = "Contrast"
    ) +
    ggplot2::theme_minimal(base_size = 14)

  print(p1)
  print(p2)

  invisible(list(slope_each_plot = p1, slope_diff_plot = p2))
}
