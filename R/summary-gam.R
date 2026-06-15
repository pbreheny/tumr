#' Summary of a GAM Fit for Tumor Growth Data
#'
#' Returns the full \code{mgcv} GAM summary and pairwise group comparisons
#' via \code{emmeans::pairs()}.
#'
#' @param object An object of class \code{"tumr_gam"}.
#' @param ... Currently ignored.
#'
#' @return An object of class \code{"summary.tumr_gam"} with components:
#' \describe{
#'   \item{\code{gam_summary}}{Full \code{mgcv::summary.gam} output.}
#'   \item{\code{pairwise_tests}}{Data frame of pairwise Wald test results
#'     with adjusted p-values.}
#'   \item{\code{relevant_info}}{Column name metadata.}
#' }
#'
#' @export

summary.tumr_gam <- function(object, ...) {
  # name of random effect
  re_terms <- c("s(.id)", "s(.id,.time)")
  # exclude random effect
  em <- emmeans::emmeans(object$fit, specs = ~ .group, exclude = re_terms)
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
  pairwise_print$p.value <- formatC(pairwise_print$p.value, format = "f", digits = 4)
  print(pairwise_print, row.names = FALSE, quote = FALSE)
  invisible(list(
    gam_summary    = summary(object$fit),
    pairwise_tests = pairwise_tests,
    relevant_info  = object$relevant_info
  ))
}