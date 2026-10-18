#' Calculate the one-half of the minimum nonzero volume
#'
#' Calculates a lower detection limit based on the smallest nonzero observed
#' tumor volume. The limit is defined as one-half of the minimum nonzero
#' `Volume` value in the data.
#'
#' @param x The tumr object.
#'
#' @returns A numeric value as the lower detection limit.
#'
#' @examples
#' data(melanoma1)
#' melanoma1$months <- melanoma1$Day / (365/12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' get_limit(mel1)
#'
#' @export
get_limit <- function(x) {
  values <- x$data[[x$measure]]
  min_nonzero <- min(values[values > 0], na.rm = TRUE)
  return(min_nonzero / 2)
}