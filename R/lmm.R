#' Linear Mixed-effects Modeling for Tumor Growth Data
#'
#' @param tumr_obj A tumr object created by [tumr()].
#' @param formula Linear mixed-effects model formula.
#' @param ... Further arguments to [lme4::lmer()].
#'
#' @returns Summary of linear mixed-effects model fit.
#'
#' @examples
#' data(melanoma1)
#' melanoma1$months <- melanoma1$Day / (365 / 12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' lmm(mel1)
#' lmm(mel1, formula = "Volume ~ Day + (1 | ID)")
#'
#' @export
lmm <- function(tumr_obj, formula = NULL,...){
  if (!inherits(tumr_obj, "tumr")) {
    stop("Input must be a tumr object")
  }
  id <- tumr_obj$id
  time <- tumr_obj$time
  measure <- tumr_obj$measure
  group <- tumr_obj$group
  data <- tumr_obj$data
  # Replace zero values with the lower limit
  limit <- get_limit(tumr_obj)
  idx <- !is.na(data[[measure]]) & data[[measure]] == 0
  data[[measure]][idx] <- limit
  if (is.null(formula)) {
    formula_string <- paste0(
      "log(", measure, ") ~ ", group, " * ", time,
      " + (", time, " | ", id, ")"
    )
    formula <- as.formula(formula_string)
  } else {
    formula <- as.formula(formula)
  }
  relevant_info <- list(ID = id, Time = time, Measure = measure, Group = group)
  model <- lme4::lmer(formula = formula,
                      data = data,
                      control = lme4::lmerControl(optimizer ='optimx', optCtrl=list(method='nlminb')),
                      ...)
  model_p <- lmerTest::as_lmerModLmerTest(model)
  result <- list(
    relevant_info = relevant_info,
    model_sum     = model,
    model         = summary(model_p)
  )
  class(result) <- "lmm"
  return(result)
}


