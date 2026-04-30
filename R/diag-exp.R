#' Diagnostic plots for exponential growth assumption
#'
#' @param lmm_obj An lmm object created by lmm().
#' @param type Diagnostic plot type. Options are:
#'   "time" for residuals vs time,
#'   "fitted" for residuals vs fitted values,
#'   "qq" for QQ plot of residuals.
#'
#' @return A ggplot object.
#'
#' @export

diag_exp <- function(lmm_obj, type = c("time", "fitted", "qq")) {
  type <- match.arg(type)
  if (!inherits(lmm_obj, "lmm")) {
    stop("lmm_obj must be an object created by lmm().")
  }
  fit <- lmm_obj$model_sum
  info <- lmm_obj$relevant_info
  time_var <- info$Time
  group_var <- info$Group
  mf <- model.frame(fit)
  diag_dat <- mf |>
    dplyr::mutate(
      fitted = stats::fitted(fit),
      resid = stats::resid(fit)
    )
  if (type == "time") {
    p <- ggplot2::ggplot(
      diag_dat,
      ggplot2::aes(
        x = .data[[time_var]],
        y = .data$resid,
        color = .data[[group_var]]
      )
    ) +
      ggplot2::geom_point(alpha = 0.5) +
      ggplot2::geom_smooth(
        ggplot2::aes(group = .data[[group_var]]),
        method = "loess",
        se = FALSE,
        linewidth = 1.1
      ) +
      ggplot2::geom_hline(yintercept = 0, linetype = 2) +
      ggplot2::facet_wrap(stats::as.formula(paste("~", group_var))) +
      ggplot2::labs(
        title = "Residuals vs Time",
        x = time_var,
        y = "Residuals from log-linear LMM"
      ) +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position = "none")
  } else if (type == "fitted") {
    p <- ggplot2::ggplot(
      diag_dat,
      ggplot2::aes(
        x = .data$fitted,
        y = .data$resid,
        color = .data[[group_var]]
      )
    ) +
      ggplot2::geom_point(alpha = 0.5) +
      ggplot2::geom_smooth(
        ggplot2::aes(group = .data[[group_var]]),
        method = "loess",
        se = FALSE,
        linewidth = 1.1
      ) +
      ggplot2::geom_hline(yintercept = 0, linetype = 2) +
      ggplot2::facet_wrap(stats::as.formula(paste("~", group_var))) +
      ggplot2::labs(
        title = "Residuals vs Fitted Values",
        x = "Fitted values",
        y = "Residuals from log-linear LMM"
      ) +
      ggplot2::theme_bw() +
      ggplot2::theme(legend.position = "none")
  } else if (type == "qq") {
    qq <- stats::qqnorm(diag_dat$resid, plot.it = FALSE)
    qq_dat <- data.frame(
      theoretical = qq$x,
      sample = qq$y
    )
    p <- ggplot2::ggplot(qq_dat, ggplot2::aes(x = theoretical, y = sample)) +
      ggplot2::geom_point(alpha = 0.7) +
      ggplot2::geom_abline(
        intercept = mean(diag_dat$resid),
        slope = stats::sd(diag_dat$resid),
        linetype = 2
      ) +
      ggplot2::labs(
        title = "QQ Plot of Residuals",
        x = "Theoretical quantiles",
        y = "Sample quantiles"
      ) +
      ggplot2::theme_bw()
  }
  return(p)
}