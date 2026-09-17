#' Calculate the Lower Detection Limit
#'
#' Calculates a lower detection limit based on the smallest nonzero observed
#' tumor volume. The limit is defined as one-half of the minimum nonzero
#' \code{Volume} value in the data.
#'
#' @param x The tumr object.
#' @return A numeric value as the lower detection limit.
#'
#' @examples
#' data(melanoma1)
#' melanoma1$months <- melanoma1$Day / (365/12)
#' mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
#' get_limit(mel1)
#'
#' @export

get_limit <- function(x) {
  min_nonzero <- min(
    x$data$Volume[x$data$Volume != 0 & !is.na(x$data$Volume)]
  )
  limit <- min_nonzero / 2
  return(limit)
}