#' Generate tumor data: Time to reach endpoint
#'
#' @param n            Number of mice (per group)
#' @param effect.size  Vector of effect sizes (default 2)
#' @param m            Number of measurements per mouse (default 3)
#' @param alpha        Shape parameter for gamma distribution (default 9)
#'
#' @return Y           Observed measurements
#' @return M           Idealized 'true' size for each mouse at each time (no error)
#' @return B           'True' growth rate for each mouse (in data-generating mechanism)
#'
#' @examples
#' Data <- gendat(5, effect.size=2, m=6)
#' matplot(Data$time, t(Data$Y[,,1]), lty=1, type='l', col='#FF4E37', bty='n', las=1,
#'         ylab=expression("Tumor volume "*(mm^3)), xlab='Day')
#' matplot(Data$time, t(Data$Y[,,2]), lty=1, type='l', col='#008DFF', add=TRUE)
#'
#' @export

gendat <- function(n, effect.size=2, m=3, alpha=9) {
  t1000 <- 21*c(1, effect.size)
  g <- length(effect.size) + 1
  time <- seq(0, max(t1000), length=m)
  M <- array(NA, dim=c(n, m, g))
  T1000 <- matrix(NA, n, g)
  for (j in 1:g) {
    T1000[,j] <- rgamma(n, alpha, alpha/t1000[j])
  }
  B <- 800/T1000
  for (i in 1:n) {
    for (k in 1:g) {
      M[i,,k] <- 200 + time*B[i,k]
    }
  }
  Y <- M
  Y[,-1,] <- Y[,-1,] + rnorm(n*(m-1)*g, sd=100)
  dimnames(Y) <- list(1:n, time, 1:g)
  list(Y=Y, M=M, time=time, B=B, t1000=t1000, T1000=T1000)
}
