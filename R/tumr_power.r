#' Power calculation for tumor growth
#'
#' For speed, uses a response feature analysis `rfeat()`; this will likely underestimate
#' power somewhat.
#'
#' @param n            Sample size per group (integer or vector)
#' @param effect_size  As in `gendat()` (numeric or vector)
#' @param N            Number of simulations (default: 1000)
#' @param ...          Other arguments to `gendat()`
#'
#' @return An array of p-values
#'
#' @examples
#' res <- tumr_power(8, 2, 10)
#' mean(res$p < 0.05)
#' @export

tumr_power <- function(n, effect_size, N=1000, ...) {
  out <- expand.grid(rep = 1:N, n = n, effect_size = effect_size, p=NA)
  pb <- utils::txtProgressBar(0, nrow(out), style=3)
  for (i in 1:nrow(out)) {
    dat <- gendat(n=out$n[i], effect_size=out$effect_size[i], ...)
    out$p[i] <- rfeat_pwr(dat)
    utils::setTxtProgressBar(pb, i)
  }
  close(pb)
  out
}

#' Analysis based on response features
#'
#' @param Data    From gendat
#' @param linear  Assume linear growth?
#'
#' @return A p-value
#'
#' @examples
#' dat <- gendat(5, 2, 6)
#' rfeat(dat)

rfeat_pwr <- function(Data, linear=TRUE) {
  y <- as.numeric(apply(Data$Y, c(1,3), function(x) coef(lm(x~Data$time))[2]))
  n <- dim(Data$Y)[1]
  g <- dim(Data$Y)[3]
  x <- rep(dimnames(Data$Y)[[3]], rep(n,g))
  if (linear) x <- as.numeric(x)
  fit <- lm(y~x)
  summary(fit)$coef[2,4]
}
