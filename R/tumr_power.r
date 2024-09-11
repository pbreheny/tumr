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
  pb <- utils::txtProgressBar(0, N, style=3)
  out <- expand.grid(rep = 1:N, n = n, effect_size = effect_size, p=NA)
  for (i in 1:nrow(out)) {
    dat <- gendat(n=out$n[i], effect_size=out$effect_size[i], ...)
    out$p[i] <- rfeat(dat)
    utils::setTxtProgressBar(pb, i)
  }
  close(pb)
  out
}
