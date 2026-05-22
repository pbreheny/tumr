#' Quadratic Linear Mixed Model for Tumor Growth Data
#'
#' Fits a quadratic linear mixed model for tumor growth data and computes
#' pairwise treatment contrasts over a grid of time points using estimated
#' marginal means.
#'
#' @param tumr_obj A `tumr` object created by [tumr()].
#' @param data Tumor growth data. Only used if `tumr_obj` is not supplied.
#' @param id Column name for subject IDs.
#' @param time Column name for repeated time measurements.
#' @param measure Column name for tumor measurements.
#' @param group Column name specifying the treatment group.
#' @param n_grid Number of time points used to evaluate treatment contrasts.
#'   Default is 20.
#' @param ... Further arguments passed to [lme4::lmer()].
#'
#' @return An object of class `quad`, which is a list containing:
#' \describe{
#'   \item{data}{The processed tumor growth data with time converted to months.}
#'   \item{fit}{The fitted quadratic linear mixed model.}
#'   \item{emm}{Estimated marginal means by treatment at each time point.}
#'   \item{contrast_obj}{Pairwise treatment contrasts.}
#'   \item{contrast_df}{A data frame containing contrast estimates and confidence intervals.}
#' }
#'
#' @examples
#' data(melanoma1)
#' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' quad_obj <- quad(mel1)
#'
#' @export

quad <- function(tumr_obj = NULL,
                 data = NULL,
                 id = NULL,
                 time = NULL,
                 measure = NULL,
                 group = NULL,
                 n_grid = 20,
                 ...) {
  if (!is.null(tumr_obj)) {
    data <- tumr_obj$data
    id <- "ID"
    time <- "Day"
    measure <- "Volume"
    group <- "Treatment"
  }
  data <- dplyr::rename(
    data,
    ID = dplyr::all_of(id),
    Time = dplyr::all_of(time),
    Volume = dplyr::all_of(measure),
    Treatment = dplyr::all_of(group)
  )
  data <- dplyr::mutate(
    data,
    Time_month = Time / 30
  )
  fit <- lme4::lmer(
    log1p(Volume) ~ (Time_month + I(Time_month^2)) * Treatment +
      (Time_month | ID),
    data = data,
    ...
  )
  time_grid <- seq(
    min(data$Time_month, na.rm = TRUE),
    max(data$Time_month, na.rm = TRUE),
    length.out = n_grid
  )
  emm <- emmeans::emmeans(
    fit,
    ~ Treatment | Time_month,
    at = list(Time_month = time_grid)
  )
  contrast_obj <- emmeans::contrast(emm, "pairwise")
  contrast_df <- as.data.frame(stats::confint(contrast_obj))
  result <- list(
    data = data,
    fit = fit,
    emm = emm,
    contrast_obj = contrast_obj,
    contrast_df = contrast_df
  )
  class(result) <- "quad"
  return(result)
}