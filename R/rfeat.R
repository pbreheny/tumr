#' Analysis based on response features
#'
#' @param Data    From gendat
#' @param linear  Assume linear growth?
#'
#' @return A p-value
#'
#' @export

rfeat <- function(Data, linear=TRUE) {
  y <- as.numeric(apply(Data$Y, c(1,3), function(x) coef(lm(x~Data$time))[2]))
  n <- dim(Data$Y)[1]
  g <- dim(Data$Y)[3]
  x <- rep(dimnames(Data$Y)[[3]], rep(n,g))
  if (linear) x <- as.numeric(x)
  fit <- lm(y~x)
  summary(fit)$coef[2,4]
}