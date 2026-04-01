#' Tumor Doubling Time Based on Fitted Tumor Growth Model
#'
#' @param x A fitted model object.
#'
#' @return A list with three components:
#' \itemize{
#'   \item \code{method}: character string describing the method used.
#'   \item \code{message}: character string indicating that the model should demonstrate an exponential growth pattern.
#'   \item \code{summary}: a data frame summarizing tumor doubling time by treatment group, including mean, median, and 95\% intervals.
#' }
#' @examples
#' data(melanoma2)
#' mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
#' fit1 <- bhm(melanoma2)
#' dtime(fit1)
#' fit2 <- lmm(mel2)
#' dtime(fit2)
#'
#' @export

dtime <- function(x) {
  if (inherits(x, "bhm")) {
    draws_slope <- posterior::as_draws_df(
      x$fit$draws(variables = "Slope")
    ) |>
      as.data.frame()
    draws_long <- draws_slope |>
      dplyr::select(dplyr::starts_with("Slope[")) |>
      tidyr::pivot_longer(
        cols = dplyr::everything(),
        names_to = "parameter",
        values_to = "slope"
      ) |>
      dplyr::mutate(
        k = as.integer(sub("Slope\\[([0-9]+)\\]", "\\1", parameter)),
        treatment = x$trt_levels[k],
        doubling_time = log(2) / slope
      )
    summary_tbl <- draws_long |>
      dplyr::group_by(treatment) |>
      dplyr::summarise(
        mean = mean(doubling_time, na.rm = TRUE),
        median = median(doubling_time, na.rm = TRUE),
        q2.5 = unname(quantile(doubling_time, 0.025, na.rm = TRUE)),
        q97.5 = unname(quantile(doubling_time, 0.975, na.rm = TRUE)),
        .groups = "drop"
      )
    return(list(
      method = "Tumor Doubling Time Based on Bayesian hierarchical Model",
      message = "The model should demonstrate an exponential growth pattern.",
      summary = summary_tbl
    ))
  }

  if (inherits(x, "lmm")) {
    fit <- x$model_sum
    time_var  <- x$relevant_info$Time
    group_var <- x$relevant_info$Group
    boot_fun_slope <- function(fit) {
      beta <- lme4::fixef(fit)
      dat <- stats::model.frame(fit)
      trt_levels <- levels(dat[[group_var]])
      slopes <- setNames(numeric(length(trt_levels)), trt_levels)
      slopes[1] <- beta[time_var]
      if (length(trt_levels) >= 2) {
        for (j in 2:length(trt_levels)) {
          int1 <- paste0(group_var, trt_levels[j], ":", time_var)
          int2 <- paste0(time_var, ":", group_var, trt_levels[j])
          if (int1 %in% names(beta)) {
            slopes[j] <- beta[time_var] + beta[int1]
          } else if (int2 %in% names(beta)) {
            slopes[j] <- beta[time_var] + beta[int2]
          } else {
            stop("Cannot find interaction term for group: ", trt_levels[j])
          }
        }
      }
      slopes
    }
    set.seed(2026)
    boot_res <- lme4::bootMer(
      fit,
      FUN = boot_fun_slope,
      nsim = 1000
    )
    dtime_mat <- log(2) / boot_res$t
    summary_tbl <- as.data.frame(
      t(apply(dtime_mat, 2, function(z) {
        c(
          mean   = mean(z, na.rm = TRUE),
          median = median(z, na.rm = TRUE),
          q2.5   = unname(quantile(z, 0.025, na.rm = TRUE)),
          q97.5  = unname(quantile(z, 0.975, na.rm = TRUE))
        )
      }))
    )
    summary_tbl[[group_var]] <- rownames(summary_tbl)
    rownames(summary_tbl) <- NULL
    summary_tbl <- summary_tbl[, c(group_var, "mean", "median", "q2.5", "q97.5"), drop = FALSE]
    summary_tbl[, c("mean", "median", "q2.5", "q97.5")] <-
      round(summary_tbl[, c("mean", "median", "q2.5", "q97.5")], 2)
    return(list(
      method = "Tumor Doubling Time Based on Linear Mixed Model",
      message = "The model should demonstrate an exponential growth pattern.",
      summary = summary_tbl
    ))
  }
  stop("x must be bhm or lmm object")
}