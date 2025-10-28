#' Linear Mixed Model for Tumor Growth Data
#'
#' @param tumr_obj takes tumr_obj created by tumr()
#' @param data  tumor growth data
#' @param id  Column of subject ID's
#' @param time Column of repeated time measurements
#' @param measure Column of repeated measurements of tumor
#' @param group Column specifying the treatment group for each measurement
#' @param formula linear mixed model formula
#'
#' @return summary of linear mixed model fit
#'
#' @examples
#' data(melanoma1)
#' meta_data <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' lmm(
#' tumr_obj = meta_data
#' )
#'
#' lmm(
#' tumr_obj = meta_data,
#' formula = "Volume ~ Day + (1 | ID)"
#' )
#'
#' data(breast)
#' lmm(
#' data = breast,
#' id = "ID",
#' group = "Treatment",
#' time = "Week",
#' measure = "Volume"
#' )
#'
#' @export

lmm <- function(tumr_obj = NULL, formula = NULL, data = NULL, id = NULL, time = NULL, measure = NULL, group = NULL){

  if (!is.null(tumr_obj)) {
    if (is.null(id)) id <- tumr_obj$id
    if (is.null(time)) time <- tumr_obj$time
    if (is.null(measure)) measure <- tumr_obj$measure
    if (is.null(group)) group <- tumr_obj$group
    if (is.null(data)) data <- tumr_obj$data
  }


  if (is.null(formula)) {
    formula_string <- paste0(measure, " ~ ", group, " * ", time, " + (", time, "| ", id, ")")
    formula <- as.formula(formula_string)
  }

  if (!is.null(formula)){
    formula <- as.formula(formula)
  }

  summary(lmerTest::lmer(formula = formula, data = data))
  #lme4::lmer(formula = formula, data = data)
}


