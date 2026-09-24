#' Creates Plots of an lmm object
#'
#' @param x lmm object
#' @param type Character string specifying which plot to produce. One of
#'   \code{"predict"}, \code{"predict_fold"} and \code{"contrast"}.
#' @param ... further arguments passed to or from other methods
#' @return A list of ggplot objects.
#'
#' @examples
#' melanoma1$months <- melanoma1$Day / (365/12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' mel1_lmm <- lmm(mel1)
#' plot(mel1_lmm, "predict")
#' plot(mel1_lmm, "predict_fold")
#' plot(mel1_lmm, "contrast")
#'
#' @export

plot.lmm <- function(x,
                     type = c("predict", "predict_fold", "contrast"),
                     ...){
  type <- match.arg(type)
  model <- x$model_sum
  if (type %in% c("predict", "predict_fold")) {
    pred <- ggeffects::ggpredict(model,
                                 terms = c(x$relevant_info$Time,
                                           x$relevant_info$Group),
                                 back_transform = FALSE
                                 )
    if (type == "predict") {
      pred_df <- as.data.frame(pred)
      p <- ggplot2::ggplot(pred_df, ggplot2::aes(x = x, y = predicted, color = group, fill = group)) +
        ggplot2::geom_ribbon(ggplot2::aes(ymin = conf.low, ymax = conf.high), alpha = 0.15, color = NA) +
        ggplot2::geom_line(linewidth = 1) +
        ggplot2::labs(
          title = "Predicted values of Volume (log scale)",
          x = x$relevant_info$Time,
          y = "Tumor measurement",
          color = x$relevant_info$Group,
          fill = x$relevant_info$Group
        ) +
        ggplot2::theme_bw() +
        ggplot2::theme(panel.border = ggplot2::element_blank())
      return(p)
    }
    if (type == "predict_fold") {
      pred_df <- as.data.frame(pred)
      pred_df <- pred_df |>
        dplyr::group_by(group) |>
        dplyr::arrange(x, .by_group = TRUE) |>
        dplyr::mutate(
          baseline = dplyr::first(predicted),
          predicted_fold = exp(predicted - baseline),
          conf.low_fold = exp(conf.low - baseline),
          conf.high_fold = exp(conf.high - baseline)
        ) |>
        dplyr::ungroup()
      p <- ggplot2::ggplot(pred_df, ggplot2::aes(x = x, y = predicted_fold, color = group, fill = group)) +
        ggplot2::geom_ribbon(ggplot2::aes(ymin = conf.low_fold, ymax = conf.high_fold), alpha = 0.15, color = NA) +
        ggplot2::geom_line(linewidth = 1) +
        ggplot2::labs(
          title = "Predicted values of Volume (log scale)",
          x = x$relevant_info$Time,
          y = "Tumor measurement (fold change)",
          color = x$relevant_info$Group,
          fill = x$relevant_info$Group) +
        ggplot2::theme_bw() +
        ggplot2::theme(panel.border = ggplot2::element_blank())
      return(p)
    }
  }
  if (type == "contrast"){
    emm_sum <- summary(x)
    return(plot(emm_sum$`slope of treatment over time`))
  }
}



