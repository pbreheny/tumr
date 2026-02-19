#' Creates plots for a bhm object
#'
#' Produces interval plots for treatment-specific slopes, slope contrasts,
#' or MCMC trace plots based on posterior summaries returned by \code{summary()}.
#'
#' @param x A \code{bhm} object returned by \code{bhm()}.
#' @param type Character string specifying which plot to produce. One of
#'   \code{"slope"}, \code{"contrast"}, or \code{"trace"}.
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
#' p1 <- plot(fit, type = "slope")
#' p2 <- plot(fit, type = "contrast")
#' p3 <- p2 + ggplot2::scale_x_continuous(transform = "exp",
#' labels = function(z) sprintf("%.2f", exp(z)))
#' plot(fit, type = "trace")
#' p3
#' }
#'
#' @export

plot.bhm <- function(x, type = c("slope", "contrast", "trace"), ...) {
  emm_sum <- summary(x)

  if (type == "slope") {
    slope_df <- emm_sum$slope_each

    p <- ggplot2::ggplot(
      slope_df,
      ggplot2::aes(
        x = .data$mean,
        y = .data$treatment
      )
    ) +
      ggplot2::geom_segment(
        ggplot2::aes(
          x = .data$q5,
          xend = .data$q95,
          yend = .data$treatment
        ),
        linewidth = 6,
        color = "#b6dfe2"
      ) +
      ggplot2::geom_point(
        shape = 18,
        size = 4,
        color = "black"
      ) +
      ggplot2::labs(
        x = "Day.trend (posterior mean with 90% credible interval)",
        y = "Treatment"
      ) +
      ggplot2::theme_minimal(base_size = 14)

    return(p)
  }

  if (type == "contrast") {
    diff_df <- emm_sum$slope_diff

    p <- ggplot2::ggplot(
      diff_df,
      ggplot2::aes(
        x = .data$mean,
        y = .data$contrast
      )
    ) +
      ggplot2::geom_segment(
        ggplot2::aes(
          x = .data$q5,
          xend = .data$q95,
          yend = .data$contrast
        ),
        linewidth = 6,
        color = "#b6dfe2"
      ) +
      ggplot2::geom_point(
        shape = 18,
        size = 4,
        color = "black"
      ) +
      ggplot2::labs(
        x = "Day.trend contrast (posterior mean with 90% credible interval)",
        y = "Contrast"
      ) +
      ggplot2::theme_minimal(base_size = 14)

    return(p)
  }

  if (type == "trace") {
    draws_array <- x$fit$draws(format = "array")
    vars <- dimnames(draws_array)$variable

    vars_int <- grep("^Int\\[", vars, value = TRUE)
    vars_slope <- grep("^Slope\\[", vars, value = TRUE)

    vars_slopediff <- grep("^SlopeDiff\\[", vars, value = TRUE)
    vars_slopediff <- vars_slopediff[!grepl("^SlopeDiff\\[([0-9]+),\\1\\]$", vars_slopediff)]

    trace_obj <- list(
      trace_intercept = bayesplot::mcmc_trace(draws_array, pars = vars_int, ...),
      trace_slope = bayesplot::mcmc_trace(draws_array, pars = vars_slope, ...),
      trace_slope_diff = bayesplot::mcmc_trace(draws_array, pars = vars_slopediff, ...)
    )
    return(trace_obj)
  }
}
