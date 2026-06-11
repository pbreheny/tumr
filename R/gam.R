#' Generalized Additive Model for Tumor Growth Data
#'
#' @param tumr_obj A \code{tumr} object created by \code{\link{tumr}}.
#' @param formula GAM formula. Defaults to
#'   \code{log(measure + 1) ~ group + s(time, by = group) +
#'   s(id, bs = "re") + s(id, time, bs = "re")}.
#' @param data A data frame of tumor growth measurements.
#' @param id Column name of subject IDs.
#' @param time Column name of repeated time measurements.
#' @param measure Column name of repeated tumor measurements.
#' @param group Column name of treatment group assignments.
#' @param n_grid Number of time grid points for prediction. Default \code{20}.
#' @param ... Further arguments passed to \code{\link[mgcv]{gam}}.
#'
#' @return An object of class \code{"tumr_gam"} with components:
#' \describe{
#'   \item{\code{fit}}{The \code{mgcv::gam} object.}
#'   \item{\code{data}}{Processed data with internal column names.}
#'   \item{\code{formula}}{The formula used.}
#'   \item{\code{relevant_info}}{Named list of column names and reference group.}
#'   \item{\code{n_grid}}{Number of prediction grid points.}
#' }
#'
#' @examples
#' data(melanoma1)
#' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' gamFit(mel1)
#'
#' @export

gamFit <- function(tumr_obj = NULL, formula = NULL, data = NULL, id = NULL,
                time = NULL, measure = NULL, group = NULL, n_grid = 20, ...) {
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
  ref_group <- levels(data[[".group"]])[1]
  data[[".group"]] <- stats::relevel(data[[".group"]], ref = ref_group)
  if (is.null(formula)) {
    formula_gam <- stats::as.formula(
      "log(.measure + 1) ~ .group + s(.time, by = .group) + s(.id, bs = 're') + s(.id, .time, bs = 're')")
  } else {
    formula_gam <- formula
  }
  # fit model
  fit <- mgcv::gam(formula = formula_gam, data = data, method = "REML")
  # result
  result <- list(
    fit           = fit,
    data          = data,
    formula       = formula_gam,
    relevant_info = list(
    ID            = id,
    Time        = time,
    Measure     = measure,
    Group       = group,
    ref_group   = ref_group),
    n_grid = n_grid
    )
  class(result) <- "tumr_gam"
  return(result)
}