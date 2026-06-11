#' Plot GAM Fit for Tumor Growth Data
#'
#' @param x An object of class \code{"tumr_gam"}.
#' @param type Either \code{"predict"} (fitted curves per group) or
#'   \code{"contrast"} (pairwise differences over time).
#' @param n_grid Number of time grid points. Defaults to \code{x$n_grid}.
#' @param ... Currently ignored.

#' @return A \code{ggplot} object.
#' @method plot tumr_gam
#' @export
#'
plot.tumr_gam <- function(x, type = c("predict", "contrast"),
                          n_grid = NULL, ...) {
  type <- match.arg(type)
  data <- x$data
  if (is.null(n_grid)) n_grid <- x$n_grid
  re_terms <- c("s(.id)", "s(.id,.time)")
  time_grid <- seq(
    min(data[[".time"]], na.rm = TRUE),
    max(data[[".time"]], na.rm = TRUE),
    length.out = n_grid
  )
  group_levels <- levels(data[[".group"]])
  pred_grid <- expand.grid(
    .time  = time_grid,
    .group = factor(group_levels, levels = group_levels),
    stringsAsFactors = FALSE
  )
  pred_grid[[".id"]] <- levels(data[[".id"]])[1]
  if (type == "predict") {
    pred <- stats::predict(
      x$fit,
      newdata = pred_grid,
      type    = "link",
      se.fit  = TRUE,
      exclude = re_terms
    )
    pred_grid$fit <- exp(pred$fit) - 1
    pred_grid$lower.CL <- exp(pred$fit - 1.96 * pred$se.fit) - 1
    pred_grid$upper.CL <- exp(pred$fit + 1.96 * pred$se.fit) - 1
    p <- ggplot2::ggplot(
      pred_grid,
      ggplot2::aes(x = .time, y = fit,
                   color = .group, fill = .group)
    ) +
      ggplot2::geom_ribbon(
        ggplot2::aes(ymin = lower.CL, ymax = upper.CL),
        alpha = 0.2, color = NA
      ) +
      ggplot2::geom_line(linewidth = 1) +
      ggplot2::labs(
        x     = x$relevant_info$Time,
        y     = x$relevant_info$Measure,
        color = x$relevant_info$Group,
        fill  = x$relevant_info$Group
      ) +
      ggplot2::theme_bw()
    return(p)
  }
  if (type == "contrast") {
    em <- emmeans::emmeans(x$fit, specs   = ~ .group | .time,
                           at = list(.time = time_grid), exclude = re_terms)
    con <- emmeans::contrast(em, method = "pairwise", adjust = "none")
    contrast_raw <- as.data.frame(con)
    contrast_df <- data.frame(
      Time     = contrast_raw[[".time"]],
      contrast = as.character(contrast_raw$contrast),
      estimate = contrast_raw$estimate,
      SE       = contrast_raw$SE,
      lower.CL = contrast_raw$estimate - 1.96 * contrast_raw$SE,
      upper.CL = contrast_raw$estimate + 1.96 * contrast_raw$SE
    )
    p <- ggplot2::ggplot(
      contrast_df,
      ggplot2::aes(x = Time, y = estimate)
    ) +
      ggplot2::geom_point() +
      ggplot2::geom_errorbar(
        ggplot2::aes(
          ymin = lower.CL,
          ymax = upper.CL
        ),
        width = 0.2,
        linewidth = 0.6
      ) +
      ggplot2::geom_hline(
        yintercept = 0,
        linetype   = "dashed",
        color      = "grey40"
      ) +
      ggplot2::facet_wrap(~ contrast) +
      ggplot2::labs(
        x = x$relevant_info$Time,
        y = "Treatment contrast (log scale)"
      ) +
      ggplot2::theme_bw()
    return(p)
    }
  }
