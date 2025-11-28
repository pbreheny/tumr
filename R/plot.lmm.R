#' Creates Plots of an lmm object
#'
#' @param x lmm object
#' @param ... further arguments passed to or from other methods
#'
#' @return 2 plots
#'
#' @examples
#' mel1 <- mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' mel1_lmm <- lmm(mel1)
#' plot(mel1_lmm)
#'
#' @export

plot.lmm <- function(x, ...){
  model <- x$model_sum

  pred <- ggeffects::ggpredict(model,
                               terms = c(x$relevant_info$Time,
                                         x$relevant_info$Group))
  pred_plot <- plot(pred)

  emm_sum <- summary(x)

  emm_plot <- plot(emm_sum$`slope of treatment over time`)

  return(list(
    predicted_measure = pred_plot,
    mean_betas = emm_plot
  ))

}



