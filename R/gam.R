#' Generalized Additive Model for Tumor Growth Data
#'
#' @param tumr_obj A \code{tumr} object created by \code{\link{tumr}}.
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
#' melanoma1$months <- melanoma1$Day / (365/12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' tumr_gam(mel1)
#'
#' @export

tumr_gam <- function(tumr_obj = NULL, n_grid = 20, ...) {
  data <- tumr_obj$data
  id <- tumr_obj$id
  time <- tumr_obj$time
  measure <- tumr_obj$measure
  group <- tumr_obj$group
  data <- dplyr::rename(
    data,
    ID = dplyr::all_of(id),
    Time = dplyr::all_of(time),
    Volume = dplyr::all_of(measure),
    Treatment = dplyr::all_of(group)
  )
  data$ID <- factor(data$ID)
  data$Treatment <- factor(data$Treatment)
  ref_group <- levels(data$Treatment)[1]
  limit <- get_limit(tumr_obj)
  idx <- !is.na(data$Volume) & data$Volume == 0
  data$Volume[idx] <- limit
  formula_gam <- stats::as.formula("log(Volume) ~ Treatment + s(Time, by = Treatment) + s(ID, bs = 're') + s(ID, Time, bs = 're')")
  # fit model
  fit <- mgcv::gam(formula = formula_gam, data = data, method = "REML", ...)
  # result
  result <- list(
    fit           = fit,
    data          = data,
    formula       = formula_gam,
    relevant_info = list(
      ID          = id,
      Time        = time,
      Measure     = measure,
      Group       = group,
      ref_group   = ref_group),
      n_grid      = n_grid
    )
  class(result) <- "tumr_gam"
  return(result)
}