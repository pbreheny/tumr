#' Analysis based on mixed model
#'
#' @param Data    From gendat
#'
#' @return A p-value
#'
#' @examples
#' Data <- gendat(5, 2, 6)
#' mixed(Data)
#'
#' @export

mixed <- function(Data) {
  DF <- reshape2::melt(Data$Y)
  names(DF) <- c("ID", "Time", "Group", "y")
  DF$ID <- paste(DF$Group, DF$ID, sep="-")
  fit <- lme4::lmer(y~Time + Time:Group + (0+Time|ID), data=DF)
  tval <- summary(fit)$coef[3,3]
  n <- dim(Data$Y)[1]
  g <- dim(Data$Y)[3]
  dfree <- n*g - 3
  2*pt(abs(tval), dfree, lower.tail=FALSE)
}
