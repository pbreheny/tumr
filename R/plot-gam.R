#' Plot GAM Fit for Tumor Growth Data
#'
#' @param x An object of class \code{"tumr_gam"}.
#' @param type Either \code{"predict"} (fitted curves per group) or
#'   \code{"contrast"} (pairwise differences over time).
#' @param n_grid Number of time grid points. Defaults to \code{x$n_grid}.
#' @param ... Currently ignored.
#'
#' @return A \code{ggplot} object.
#'
#' @examples
#' data(melanoma1)
#' melanoma1$months <- melanoma1$Day / (365/12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' fit_gam <- tumr_gam(mel1)
#' plot(fit_gam, "predict")
#' plot(fit_gam, "contrast")
#'
#' @method plot tumr_gam
#' @export

plot.tumr_gam <- function(x, type = c("predict", "contrast"),
                          n_grid = NULL, ...) {
  type <- match.arg(type)
  data <- x$data
  if (is.null(n_grid)) n_grid <- x$n_grid
  re_terms <- c("s(ID)", "s(ID, Time)")
  time_grid <- seq(
    min(data[["Time"]], na.rm = TRUE),
    max(data[["Time"]], na.rm = TRUE),
    length.out = n_grid
  )
  group_levels <- levels(data[["Treatment"]])
  pred_grid <- expand.grid(
    Time  = time_grid,
    Treatment = factor(group_levels, levels = group_levels),
    stringsAsFactors = FALSE
  )
  pred_grid[["ID"]] <- levels(data[["ID"]])[1]
  if (type == "predict") {
    pred <- ggeffects::predict_response(
      x$fit,
      terms = c("Time [all]", "Treatment"),
      exclude = c(
        "s(ID)",
        "s(ID,Time)"
      ),
      newdata.guaranteed = TRUE,
      back_transform = FALSE
    )
    p <- plot(pred) +
      ggplot2::labs(
        x = "Time",
        y = "Tumor measurement (log scale)",
        color = "Treatment",
        fill = "Treatment"
      ) +
      ggplot2::theme_bw()
    return(p)
  }
  if (type == "contrast") {
    em <- emmeans::emmeans(x$fit, specs   = ~ Treatment | Time,
                           at = list(Time = time_grid), exclude = re_terms)
    con <- emmeans::contrast(em, method = "pairwise", adjust = "none")
    contrast_raw <- as.data.frame(con)
    contrast_df <- data.frame(
      Time     = contrast_raw[["Time"]],
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
        color      = "red"
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
