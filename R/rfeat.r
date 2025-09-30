#' Analysis based on response features
#'
#' Volume ~ Week * Trt, separate function that picks apart this
#'
#' exponential growth, separate packages
#'
#' @param data    From gendat
#' @param id  Column of subject ID's
#' @param time Column of repeated time measurements
#' @param measure Column of repeated measurements of tumor
#' @param group Column specifying the treatment group for each measurement
#' @param transformation transformation of measurement
#' @param comparison Takes "t.test", "anova", "tukey", or "both"
#'
#' @return A p-value
#'
#' @examples
#' data(breast)
#' rfeat(breast, "ID", "Week", "Volume", "Treatment", transformation = log1p,
#' comparison = "t.test")
#' data(melanoma1)
#' rfeat(melanoma1, "ID", "Day", "Volume", "Treatment", comparison = "anova")
#' rfeat(melanoma1, "ID", "Day", "Volume", "Treatment", comparison = "both")
#' @export

rfeat <- function(data, id, time, measure, group, transformation = NULL, comparison) {
   unique_ids <- unique(data[[id]])

  betas <- data.frame(
    ID = numeric(length(unique_ids)),
    Beta = numeric(length(unique_ids)),
    Group = character(length(unique_ids)),
    stringsAsFactors = FALSE
  )

  for (j in seq_along(unique_ids)) {
    i <- unique_ids[j]
    smaller <- data[data[[id]] == i, ]

    # Skip if insufficient data for linear model
    if (nrow(smaller) < 2) next

    if (is.null(transformation)){
      formula_str <- paste(measure, "~", time)
    } else {
      formula_str <- paste("transformation", "(",measure, ")", "~", time)
    }

    model <- lm(as.formula(formula_str), data = smaller)

    betas[j, "ID"] <- i
    betas[j, "Beta"] <- coef(model)[[time]]
    betas[j, "Group"] <- as.character(unique(smaller[[group]]))
  }

  # Remove rows with NA (e.g., from skipped IDs)
  #betas <- na.omit(betas)

  # Group-level summary
  betas_summary <- betas |>
    dplyr::group_by(Group) |>
    dplyr::summarise(average = mean(Beta), .groups = "drop")

  # Corrected statistical test using individual-level data
  #length(unique(betas$Group)) == 2
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


  relevant_info <- list(
    ID = id,
    Time = time,
    Measure = measure,
    Group = group
  )

  result <- list(
    relevant_information = relevant_info,
    betas = betas,
    summary = betas_summary,
    test = stat_test
  )

  class(result) <- "rfeat"

  return(result)
}

