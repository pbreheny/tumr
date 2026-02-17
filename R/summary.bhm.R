#' Creates a summary of a bhm object
#'
#' @param object bhm object
#' @param ... further arguments passed to or from other methods
#'
#' @return a list containing posterior summaries on log scale and exp scale
#'
#' @examples
#' \dontrun{
#' data(melanoma2)
#' fit <- bhm(melanoma2)
#' summary(fit)
#' }
#' @export

summary.bhm <- function(object, ...) {

  slope_each <- object$slope_each
  slope_diff <- object$slope_diff
  int_each <- object$int_each

  # Intercept
  int_each$exp_mean <- exp(int_each$mean)
  int_each$exp_q5 <- exp(int_each$q5)
  int_each$exp_q95 <- exp(int_each$q95)

  int_each <- int_each[, c(
    "treatment",
    "mean", "q5", "q95",
    "exp_mean", "exp_q5", "exp_q95"
  )]

  # Slope
  slope_each$growth_factor_mean <- exp(slope_each$mean)
  slope_each$growth_factor_q5 <- exp(slope_each$q5)
  slope_each$growth_factor_q95 <- exp(slope_each$q95)

  slope_each$pct_change_mean <- (slope_each$growth_factor_mean - 1) * 100
  slope_each$pct_change_q5 <- (slope_each$growth_factor_q5 - 1) * 100
  slope_each$pct_change_q95 <- (slope_each$growth_factor_q95 - 1) * 100

  slope_each <- slope_each[, c(
    "treatment",
    "mean", "q5", "q95",
    "growth_factor_mean",
    "growth_factor_q5",
    "growth_factor_q95",
    "pct_change_mean",
    "pct_change_q5",
    "pct_change_q95"
  )]

  # Pairwise slope differences
  slope_diff$ratio_mean <- exp(slope_diff$mean)
  slope_diff$ratio_q5 <- exp(slope_diff$q5)
  slope_diff$ratio_q95 <- exp(slope_diff$q95)

  slope_diff$pct_diff_mean <- (slope_diff$ratio_mean - 1) * 100
  slope_diff$pct_diff_q5 <- (slope_diff$ratio_q5 - 1) * 100
  slope_diff$pct_diff_q95 <- (slope_diff$ratio_q95 - 1) * 100

  slope_diff <- slope_diff[, c(
    "contrast",
    "mean", "q5", "q95",
    "ratio_mean",
    "ratio_q5",
    "ratio_q95",
    "pct_diff_mean",
    "pct_diff_q5",
    "pct_diff_q95"
  )]

  return(list(
    int_each = int_each,
    slope_each = slope_each,
    slope_diff = slope_diff
  ))
}
