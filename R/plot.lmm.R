#' Creates Plots of an lmm object
#'
#' @param x lmm object
#' @param type Character string specifying which plot to produce. One of
#'   \code{"predict"} or \code{"slope"}.
#' @param ... further arguments passed to or from other methods
#' @return A list of ggplot objects.
#'
#' @examples
#' mel1 <- mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' mel1_lmm <- lmm(mel1)
#' plot(mel1_lmm, "predict")
#' plot(mel1_lmm, "slope")
#' @export

plot.lmm <- function(x, type = c("predict", "slope"), ...){
  model <- x$model_sum
  if (type == "predict") {
    pred <- ggeffects::ggpredict(model,
                                 terms = c(x$relevant_info$Time,
                                           x$relevant_info$Group))
    pred_plot <- plot(pred)
    pred_plot
  }

  if (type == "slope") {
    emm_sum <- summary(x)
    emm_plot <- plot(emm_sum$`slope of treatment over time`)
    emm_plot
  }
}



