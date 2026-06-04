#' Generalized Additive Mixed Model for Tumor Growth Data
#'
#' @param tumr_obj A \code{tumr} object created by \code{\link{tumr}}.
#' @param formula GAM fixed-effects formula. Defaults to
#'   \code{log(measure + 1) ~ group + s(time, by = group)}.
#' @param data A data frame of tumor growth measurements.
#' @param id Column name of subject IDs.
#' @param time Column name of repeated time measurements.
#' @param measure Column name of repeated tumor measurements.
#' @param group Column name of treatment group assignments.
#' @param n_grid Number of time grid points for pairwise contrasts. Default \code{20}.
#' @param ... Further arguments passed to \code{\link[gamm4]{gamm4}}.
#'
#' @return An object of class \code{"gam"} with components \code{relevant_info},
#'   \code{formula}, \code{fit} (the \code{gamm4} object), and \code{contrast_df}
#'   (pairwise group contrasts with SE and 95\% CI at each time grid point).
#'
#' @examples
#' data(melanoma1)
#' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' gam(mel1)
#'
#' @export

gam <- function(tumr_obj = NULL,
                formula = NULL,
                data = NULL,
                id = NULL,
                time = NULL,
                measure = NULL,
                group = NULL,
                n_grid = 20,
                ...) {
  if (!is.null(tumr_obj)) {
    if (is.null(id)) id <- tumr_obj$id
    if (is.null(time)) time <- tumr_obj$time
    if (is.null(measure)) measure <- tumr_obj$measure
    if (is.null(group)) group <- tumr_obj$group
    if (is.null(data)) data <- tumr_obj$data
  }
  data[[".id"]] <- base::as.factor(data[[id]])
  data[[".time"]] <- data[[time]]
  data[[".measure"]] <- data[[measure]]
  data[[".group"]] <- base::as.factor(data[[group]])
  ref.group <- levels(data[[".group"]])[1]
  data[[".group"]] <- stats::relevel(data[[".group"]], ref = ref.group)
  if (is.null(formula)) {
    formula_gam <- stats::as.formula(
      "log(.measure + 1) ~ .group + s(.time, by = .group)"
    )
  } else {
    formula_gam <- formula
  }
  formula_random <- stats::as.formula("~ (.time | .id)")
  fit <- gamm4::gamm4(
    formula = formula_gam,
    random = formula_random,
    data = data,
    REML = TRUE
  )
  time_grid <- seq(
    min(data[[".time"]], na.rm = TRUE),
    max(data[[".time"]], na.rm = TRUE),
    length.out = n_grid
  )
  group_levels <- levels(data[[".group"]])
  pred_grid <- expand.grid(
    .time = time_grid,
    .group = group_levels
  )
  # design matrix
  X <- stats::predict(
    fit$gam,
    newdata = pred_grid,
    type = "lpmatrix"
  )
  beta <- stats::coef(fit$gam)
  V <- stats::vcov(fit$gam)
  pair_list <- utils::combn(group_levels, 2, simplify = FALSE)
  contrast_df <- do.call(
    rbind,
    lapply(pair_list, function(pair) {
      g1 <- pair[1]
      g2 <- pair[2]
      do.call(
        rbind,
        lapply(time_grid, function(t) {
          row1 <- which(pred_grid$.time == t & pred_grid$.group == g1)
          row2 <- which(pred_grid$.time == t & pred_grid$.group == g2)
          # contrast vector
          L <- X[row1, , drop = FALSE] - X[row2, , drop = FALSE]
          # point estimate (difference of log scale)
          estimate <- as.numeric(L %*% beta)
          se <- sqrt(as.numeric(L %*% V %*% t(L)))
          data.frame(
            Time = t,
            contrast = paste(g1, "-", g2),
            estimate = estimate,
            SE = se,
            lower.CL = estimate - 1.96 * se,
            upper.CL = estimate + 1.96 * se
          )
        })
      )
    })
  )
  result <- list(
    relevant_info = list(
      ID = id,
      Time = time,
      Measure = measure,
      Group = group,
      ref_group = ref.group
    ),
    formula = list(
      gam = formula_gam,
      random = formula_random
    ),
    fit = fit,
    contrast_df = contrast_df
  )
  class(result) <- "tumr_gam"
  return(result)
}