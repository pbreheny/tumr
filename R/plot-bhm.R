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
#' If \code{type} is \code{"predict"}, \code{"slope"}, or \code{"contrast"}, returns a \code{ggplot} object.
#' If \code{type} is \code{"trace"}, returns a list of \code{ggplot} objects with elements
#' \code{trace_intercept}, \code{trace_slope}, and \code{trace_slope_diff}.
#'
#' @examples
#' \dontrun{
#' data("melanoma1")
#' fit <- bhm(melanoma1)
#' plot(fit, type = "predict")
#' plot(fit, type = "slope")
#' plot(fit, type = "contrast")
#' plot(fit, type = "contrast") +
#'   ggplot2::scale_x_continuous(
#'     labels = function(z) scales::number(exp(z), 0.01))
#' plot(fit, type = "trace")
#' }
#'
#' @export

plot.bhm <- function(x, type = c("predict", "slope", "contrast", "trace"), ...) {
  type <- match.arg(type)
  emm_sum <- summary(x)

  if (type == "predict") {
    fit <- x$fit
    draws_mat <- posterior::as_draws_matrix(fit$draws())
    K <- length(grep("^Int\\[", colnames(draws_mat)))
    Int_cols <- paste0("Int[", 1:K, "]")
    Slope_cols <- paste0("Slope[", 1:K, "]")
    Int_draws <- draws_mat[, Int_cols, drop = FALSE]
    Slope_draws <- draws_mat[, Slope_cols, drop = FALSE]
    t_grid <- seq(min(x$t_range), max(x$t_range), length.out = 100)
    q_list <- vector("list", K)
    for (g in 1:K) {
      slope_g <- matrix(Slope_draws[, g], ncol = 1)
      int_g <- matrix(Int_draws[, g], ncol = 1)
      prod <- slope_g %*% t(t_grid)
      mu_g <- sweep(prod, 1, int_g[,1], "+")
      q_list[[g]] <- apply(mu_g, 2, quantile, probs = c(0.025, 0.5, 0.975))
    }
    pred_df <- purrr::imap_dfr(q_list, function(q, g) {
      tibble::tibble(
        treatment = g,
        t = t_grid,
        lo = q[1, ],
        mid = q[2, ],
        hi = q[3, ]
      )
    })
    pred_df$treatment <- factor(
      pred_df$treatment,
      levels = sort(unique(pred_df$treatment)),
      labels = LETTERS[seq_along(unique(pred_df$treatment))]
    )
    p <- ggplot2::ggplot(
      pred_df,
      ggplot2::aes(
        x = .data$t,
        y = .data$mid,
        group = .data$treatment,
        color = .data$treatment,
        fill = .data$treatment
      )
    ) +
      ggplot2::geom_ribbon(
        ggplot2::aes(ymin = .data$lo, ymax = .data$hi),
        alpha = 0.2,
        color = NA
      ) +
      ggplot2::geom_line(linewidth = 1) +
      ggplot2::labs(
        title = "Predicted values of Volume",
        x = "months",
        y = "Volume",
        color = "Treatment",
        fill = "Treatment"
      )
    return(p)
  }

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