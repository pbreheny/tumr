#' Power calculation for tumor growth
#'
#' For speed, uses a response feature analysis `rfeat()`; this will likely underestimate
#' power somewhat.
#'
#' @param n            Sample size per group (integer or vector)
#' @param effect.size  As in `gendat()` (numeric or vector)
#' @param N            Number of simulations (default: 1000)
#' @param ...          Other arguments to `gendat()`
#'
#' @return An array of p-values
#'
#' @examples
#' p <- tumrPower(8, 2, 6)
#'
#' @export

tumrPower <- function(n, effect.size, N=1000, ...) {
  p <- array(NA, dim=c(N, length(n), length(effect.size)), dimnames=list(1:N, n, effect.size))

  pb <- utils::txtProgressBar(0, N, style=3)
  for (i in 1:N) {
    for (j in 1:length(n)) {
      for (k in 1:length(effect.size)) {
        Data <- gendat(n=n[j], effect.size=effect.size[k], ...)
        p[i,j,k] <- rfeat(Data)
      }
    }
    utils::setTxtProgressBar(pb, i)
  }
  p
}
