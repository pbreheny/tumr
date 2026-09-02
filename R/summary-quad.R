#' Summary of Exponential quadratic model
#'
#' Returns the full linear mixed-model summary and pairwise treatment
#' comparisons based on estimated marginal means.
#'
#' @param object An object of class \code{"quad"}.
#' @param ... Currently ignored.
#'
#' @return An object of class \code{"summary.quad"} containing:
#' \describe{
#'   \item{\code{model_summary}}{Full summary of the fitted linear mixed model.}
#'   \item{\code{pairwise_tests}}{Pairwise treatment comparisons with
#'     Holm-adjusted p-values.}
#' }
#'
#' @method summary quad
#' @export

summary.quad <- function(object, ...) {
  em <- emmeans::emmeans(object$fit, specs = ~ Treatment)
  con <- emmeans::contrast(em, method = "pairwise", adjust = "holm")
  pairwise_raw <- as.data.frame(con)
  pairwise_tests <- data.frame(
    contrast = as.character(pairwise_raw$contrast),
    estimate = pairwise_raw$estimate,
    SE = pairwise_raw$SE,
    p.value = pairwise_raw$p.value,
    stringsAsFactors = FALSE
  )
  pairwise_print <- pairwise_tests
  pairwise_print$p.value <- formatC(
    pairwise_print$p.value,
    format = "f",
    digits = 4
  )
  print(pairwise_print, row.names = FALSE, quote = FALSE)
  invisible(list(
    model_summary  = summary(object$fit),
    pairwise_tests = pairwise_tests
  ))
}