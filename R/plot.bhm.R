#' Creates plots for a bhm object
#'
#' Produces interval plots for treatment-specific slopes, slope contrasts,
#' or MCMC trace plots based on posterior summaries returned by \code{summary()}.
#'
#' @param x A \code{bhm} object returned by \code{bhm()}.
#' @param type Character string specifying which plot to produce. One of
#'   \code{"predicted"}, \code{"slope"}, \code{"contrast"}, or \code{"trace"}.
#' @param ... Further arguments passed to trace plotting functions (currently used
#'   only when \code{type = "trace"}).
#'
#' @return
#' If \code{type} is \code{"slope"} or \code{"contrast"}, returns a \code{ggplot} object.
#' If \code{type} is \code{"trace"}, returns a list of \code{ggplot} objects with elements
#' \code{trace_intercept}, \code{trace_slope}, and \code{trace_slope_diff}.
#'
#' @examples
#' \dontrun{
#' data("melanoma1")
#' fit <- bhm(melanoma1)
#' plot(fit, type = "slope")
#' plot(fit, type = "contrast")
#' plot(fit, type = "trace")
#' }
#'
#' @export

plot.bhm <- function(x, type = c("predicted", "slope", "contrast", "trace"), ...) {
  type <- match.arg(type)
  emm_sum <- summary(x)

  interval_plot <- function(df, yvar, ylab) {
    ggplot2::ggplot(df, ggplot2::aes(y = {{ yvar }})) +
      ggplot2::geom_segment(
        ggplot2::aes(x = .data$q5, xend = .data$q95, yend = {{ yvar }}),
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
        y = ylab
      ) +
      ggplot2::theme_minimal(base_size = 14)
  }

  if (type == "slope") {
    slope_df <- emm_sum$slope_each
    return(interval_plot(slope_df, .data$treatment, "Treatment"))
  }

  if (type == "contrast") {
    diff_df <- emm_sum$slope_diff
    return(interval_plot(diff_df, .data$contrast, "Contrast"))
  }

  if (type == "trace") {
    draws_array <- x$fit$draws(format = "array")
    vars <- dimnames(draws_array)$variable

    vars_int   <- grep("^Int\\[", vars, value = TRUE)
    vars_slope <- grep("^Slope\\[", vars, value = TRUE)

    vars_slopediff <- grep("^SlopeDiff\\[", vars, value = TRUE)
    vars_slopediff <- vars_slopediff[!grepl("^SlopeDiff\\[([0-9]+),\\1\\]$", vars_slopediff)]

    trace_obj <- list(
      trace_intercept  = bayesplot::mcmc_trace(draws_array, pars = vars_int, ...),
      trace_slope      = bayesplot::mcmc_trace(draws_array, pars = vars_slope, ...),
      trace_slope_diff = bayesplot::mcmc_trace(draws_array, pars = vars_slopediff, ...)
    )
    return(trace_obj)
  }
}
