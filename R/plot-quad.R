#' Plot the result of Exponential quadratic model
#'
#' Plots fitted treatment-specific quadratic growth curves or pairwise
#' treatment contrasts over time from a fitted \code{quad} object.
#'
#' @param x An object of class \code{"quad"}.
#' @param type Type of plot to produce. Either \code{"predict"} for fitted
#'   treatment-specific growth curves or \code{"contrast"} for pairwise
#'   treatment contrasts over time. Default is \code{"predict"}.
#' @param n_grid Number of time points used to construct the fitted curves.
#'   Default is 20.
#' @param ... Additional arguments passed to plotting functions.
#'
#' @return A \code{ggplot} object.
#'
#' @examples
#' data(melanoma1)
#' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' quad_obj <- quad(mel1)
#'
#' # Fitted quadratic growth curves
#' plot(quad_obj, type = "predict")
#' # Pairwise treatment contrasts over time
#' plot(quad_obj, type = "contrast")
#'
#' @method plot quad
#' @export

plot.quad <- function(x,
                      type = c("predict", "contrast"),
                      n_grid = 20,
                      ...) {

  type <- match.arg(type)
  if (type == "predict") {
    time_grid <- seq(
      min(x$data$Time, na.rm = TRUE),
      max(x$data$Time, na.rm = TRUE),
      length.out = n_grid
    )
    model_data <- stats::model.frame(x$fit)
    treatment_levels <- levels(factor(model_data$Treatment))
    pred_grid <- expand.grid(
      Time = time_grid,
      Treatment = treatment_levels,
      stringsAsFactors = FALSE
    )
    pred_grid$Treatment <- factor(
      pred_grid$Treatment,
      levels = treatment_levels
    )
    fixed_formula <- stats::delete.response(
      stats::terms(
        lme4::nobars(stats::formula(x$fit))
      )
    )
    X <- stats::model.matrix(
      fixed_formula,
      data = pred_grid
    )
    beta <- lme4::fixef(x$fit)
    X <- X[, names(beta), drop = FALSE]
    V <- as.matrix(stats::vcov(x$fit))
    pred_grid$link_fit <- drop(X %*% beta)
    pred_grid$link_se <- sqrt(rowSums((X %*% V) * X))
    pred_grid$link_lower <- pred_grid$link_fit - 1.96 * pred_grid$link_se
    pred_grid$link_upper <- pred_grid$link_fit + 1.96 * pred_grid$link_se
    pred_grid$fit <- expm1(pred_grid$link_fit)
    pred_grid$lower.CL <- expm1(pred_grid$link_lower)
    pred_grid$upper.CL <- expm1(pred_grid$link_upper)
    p <- ggplot2::ggplot(
      pred_grid,
      ggplot2::aes(
        x = Time,
        y = fit,
        color = Treatment,
        fill = Treatment
      )
    ) +
      ggplot2::geom_ribbon(
        ggplot2::aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        alpha = 0.2,
        color = NA
      ) +
      ggplot2::geom_line(
        linewidth = 1
      ) +
      ggplot2::labs(
        x = "Time",
        y = "Tumor measurement",
        color = "Treatment",
        fill = "Treatment"
      ) +
      ggplot2::theme_bw()

    return(p)
  }
  if (type == "contrast") {
    contrast_times <- sort(unique(x$contrast_df$Time))
    errorbar_width <- 0.1
    p <- ggplot2::ggplot(
      x$contrast_df,
      ggplot2::aes(
        x = Time,
        y = estimate
      )
    ) +
      ggplot2::geom_point() +
      ggplot2::geom_errorbar(
        ggplot2::aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        width = errorbar_width,
        linewidth = 0.6
      ) +
      ggplot2::geom_hline(
        yintercept = 0,
        linetype = "dashed",
        color = "grey40"
      ) +
      ggplot2::facet_wrap(
        ~ contrast
      ) +
      ggplot2::labs(
        x = "Time",
        y = "Treatment contrast (log scale)"
      ) +
      ggplot2::theme_bw()
    return(p)
  }
}