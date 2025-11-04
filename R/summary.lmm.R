#' Creates a summary of an lmm object
#'
#' @param object lmm object
#' @param ... further arguments passed to or from other methods
#'
#' @return a summary of the lmm object
#'
#' @examples
#' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' mel1_lmm <- lmm(mel1)
#' summary(mel1_lmm)
#'
#' @export

summary.lmm <- function(object, ...) {
  group_var <- object$relevant_info$Group

  overall_effect <- emmeans::emtrends(object$model_sum,
                                      ~ 1,
                                      var = object$relevant_info$Time)
  effect_by_time <- emmeans::emtrends(object$model_sum,
                                      specs = reformulate(group_var),
                                      var = object$relevant_info$Time)
  contrast_slopes <- emmeans::contrast(effect_by_time, method = "pairwise")


  result <- list(
    'overall effect of time' = overall_effect,
    'slope of treatment over time' = effect_by_time,
    'test slope differences' = contrast_slopes
  )

  return(result)
}



