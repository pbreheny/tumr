#' Analysis based on response features
#'
#' @param Data    From gendat
#' @param linear  Assume linear growth?
#'
#' @return A p-value
#'
#' @examples
#' Data <- gendat(5, 2, 6)
#' rfeat(Data)
#'
#' @export

# rfeat <- function(Data, linear=TRUE) {
#   y <- as.numeric(apply(Data$Y, c(1,3), function(x) coef(lm(x~Data$time))[2]))
#   n <- dim(Data$Y)[1]
#   g <- dim(Data$Y)[3]
#   x <- rep(dimnames(Data$Y)[[3]], rep(n,g))
#   if (linear) x <- as.numeric(x)
#   fit <- lm(y~x)
#   summary(fit)$coef[2,4]
# }




#Volume ~ Week * Trt, separate function that picks apart this

rfeat <- function(data, id, time, measure, group) {
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

    formula_str <- paste(measure, "~", time)
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
  if (length(unique(betas$Group)) == 2) {
    stat_test <- t.test(Beta ~ Group, data = betas)
  } else {
    stat_test <- summary(aov(Beta ~ Group, data = betas))
  }

  # Plot
  plot <- ggplot2::ggplot(betas, ggplot2::aes(x = Group, y = Beta, color = Group)) +
    ggplot2::geom_jitter(width = 0.2, size = 2) +
    ggplot2::stat_summary(fun = mean, geom = "point", shape = 18, size = 4, color = "black") +
    ggplot2::labs(title = "Individual Slopes (Betas) by Group",
                  y = paste("Slope of", measure, "vs", time),
                  x = group) +
    ggplot2::theme_minimal()

  return(list(
    betas = betas,
    summary = betas_summary,
    test = stat_test,
    plot = plot
  ))
}

rfeat(breast, "ID", "Week", "Volume", "Treatment")
rfeat(melanoma1, "ID", "Day", "Volume", "Treatment")
rfeat(melanoma2, "ID", "Day", "Volume", "Treatment")
rfeat(prostate, "ID", "Age", "BLI", "Genotype")


#exponential growth, separate packages

#log1p function for log transformation

#log transformed version

rfeat_1p <- function(data, id, time, measure, group) {
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

    formula_str <- paste("log1p(",measure, ")", "~", time)
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
  if (length(unique(betas$Group)) == 2) {
    stat_test <- t.test(Beta ~ Group, data = betas)
  } else {
    stat_test <- summary(aov(Beta ~ Group, data = betas))
  }

  # Plot
  plot <- ggplot2::ggplot(betas, ggplot2::aes(x = Group, y = Beta, color = Group)) +
    ggplot2::geom_jitter(width = 0.2, size = 2) +
    ggplot2::stat_summary(fun = mean, geom = "point", shape = 18, size = 4, color = "black") +
    ggplot2::labs(title = "Individual Slopes (Betas) by Group",
                  y = paste("Slope of", measure, "vs", time),
                  x = group) +
    ggplot2::theme_minimal()

  return(list(
    betas = betas,
    summary = betas_summary,
    test = stat_test,
    plot = plot
  ))
}

rfeat_1p(breast, "ID", "Week", "Volume", "Treatment")
rfeat_1p(melanoma1, "ID", "Day", "Volume", "Treatment")
rfeat_1p(melanoma2, "ID", "Day", "Volume", "Treatment")
rfeat_1p(prostate, "ID", "Age", "BLI", "Genotype")
