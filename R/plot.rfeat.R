#' Plot based on rfeat analysis
#'
#' @param x An rfeat object
#' @param ... Other parameters
#'
#' @return A plot
#'
#' @examples
#' example <- rfeat(breast, "ID", "Week", "Volume", "Treatment",
#' transformation = log1p, comparison = "t.test")
#' plot(example)
#' @export



plot.rfeat <- function (x, ...) {

  ggplot2::ggplot(x$betas, ggplot2::aes(x = x$betas$Group, y = x$betas$Beta, color = x$betas$Group)) +
    ggplot2::geom_jitter(width = 0.2, size = 2) +
    ggplot2::stat_summary(fun = mean, geom = "point", shape = 18, size = 4, color = "black") +
    ggplot2::labs(title = "Individual Slopes (Betas) by Group",
                  y = paste("Slope of", x$relevant_information["Measure"], "vs", x$relevant_information["Time"]),
                  x = x$relevant_information["Group"]) +
    ggplot2::theme_minimal()

}

