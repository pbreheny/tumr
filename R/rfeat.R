#' Analysis Based on Response Features
#'
#' Analyze individual tumor growth rates and compare them across
#' treatment groups.
#'
#' @param tumr_obj A tumr object created by `tumr()`.
#' @param log Whether to apply log1p transformation to the tumor
#'   measurements. Default is TRUE.
#' @param comparison Statistical comparison method. One of
#'   "t.test", "anova", "tukey", or "both".
#'
#' @returns A list with four components:
#'
#' - `relevant_information`: Variables used in the analysis.
#' - `betas`: Individual-level estimated slopes.
#' - `summary`: Average slope for each treatment group.
#' - `test`: Results of the selected statistical test.
#'
#' @examples
#' data(breast)
#' breast_obj <- tumr(breast, ID, Week, Volume, Treatment)
#' rfeat(breast_obj, comparison = "t.test")
#'
#' data(melanoma1)
#' melanoma_obj <- tumr(melanoma1, ID, Day, Volume, Treatment)
#' rfeat(melanoma_obj, comparison = "anova")
#'
#' @export
rfeat <- function(tumr_obj = NULL,
                  log = TRUE,
                  comparison = c("t.test", "anova", "tukey", "both")) {
  if (!inherits(tumr_obj, "tumr")) {
    stop("tumr_obj must be a tumr object.")
  }
  comparison <- match.arg(comparison)
  id <- tumr_obj$id
  time <- tumr_obj$time
  measure <- tumr_obj$measure
  group <- tumr_obj$group
  data <- tumr_obj$data
  unique_ids <- unique(data[[id]])
  betas <- data.frame(
    ID = character(length(unique_ids)),
    Beta = numeric(length(unique_ids)),
    Group = character(length(unique_ids)),
    stringsAsFactors = FALSE
  )
  for (j in seq_along(unique_ids)) {
    i <- unique_ids[j]
    smaller <- data[data[[id]] == i, ]
    # Skip if insufficient data for linear model
    if (nrow(smaller) < 2) next
    if (log == FALSE){
      formula_str <- paste(measure, "~", time)
    } else {
      formula_str <- paste("log1p(", measure, ")", "~", time)
    }
    model <- lm(as.formula(formula_str), data = smaller)
    betas[j, "ID"] <- as.character(i)
    betas[j, "Beta"] <- coef(model)[[time]]
    betas[j, "Group"] <- as.character(unique(smaller[[group]]))
  }
  betas <- betas[betas$ID != "", , drop = FALSE]
  # Group-level summary
  betas_summary <- betas |>
    dplyr::group_by(.data[["Group"]]) |>
    dplyr::summarise(average = mean(.data[["Beta"]]), .groups = "drop")
  # Corrected statistical test using individual-level data
  if (comparison == "t.test") {
    stat_test <- t.test(Beta ~ Group, data = betas)
  } else if (comparison == "anova") {
    stat_test <- summary(aov(Beta ~ Group, data = betas))
  } else if (comparison == "tukey") {
    stat_test <- TukeyHSD(aov(Beta ~ Group, data = betas))
  } else if (comparison == "both") {
    stat_test <- list(
      anova = summary(aov(Beta ~ Group, data = betas)),
      tukey = TukeyHSD(aov(Beta ~ Group, data = betas))
    )
  }
  relevant_info <- list(ID = id, Time = time, Measure = measure, Group = group)
  result <- list(relevant_information = relevant_info, betas = betas, summary = betas_summary, test = stat_test)
  class(result) <- "rfeat"
  return(result)
  print(result)
}

