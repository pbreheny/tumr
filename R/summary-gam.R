#' Summary of a GAM Fit for Tumor Growth Data
#'
#' @param object An object of class \code{"tumr_gam"} returned by \code{\link{gam}}.
#' @param ... Currently ignored.
#'
#' @return A list with components:
#' \describe{
#'   \item{\code{parametric_coefficients}}{Group effect estimates with Holm- and
#'     Hommel-adjusted p-values.}
#'   \item{\code{smooth_terms}}{Smooth term significance table.}
#'   \item{\code{gam_summary}}{Full GAM summary from \code{mgcv}.}
#'   \item{\code{mer_summary}}{Mixed-effects summary from \code{lme4}.}
#' }
#'
#' @export

summary.tumr_gam <- function(object, ...) {
  gam.sum <- summary(object$fit$gam)
  mer.sum <- base::summary(object$fit$mer)
  coef <- gam.sum$p.table[-1, , drop = FALSE]
  coef <- base::as.data.frame(coef)
  colnames(coef)[4] <- "p.value"
  coef$Holm.adjusted.p.value <- stats::p.adjust(
    coef$p.value,
    method = "holm"
  )
  coef$Hommel.adjusted.p.value <- stats::p.adjust(
    coef$p.value,
    method = "hommel"
  )
  result <- list(
    relevant_info = object$relevant_info,
    formula = object$formula,
    parametric_coefficients = coef,
    smooth_terms = gam.sum$s.table,
    gam_summary = gam.sum,
    mer_summary = mer.sum
  )
  return(result)
}