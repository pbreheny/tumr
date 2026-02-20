#' Analysis based on repeated measures ANOVA
#'
#' @param Data    From gendat
#'
#' @return A p-value
#'
#' @examples
#' Data <- gendat(5, 2, 6)
#' rmanova(Data)
#'
#' @export

rmanova <- function(Data) {
  DF <- as.data.frame.table(Data$Y, stringsAsFactors = FALSE)
  names(DF) <- c("ID", "Time", "Group", "y")
  DF$Time <- as.numeric(DF$Time)
  DF$ID <- paste(DF$Group, DF$ID, sep="-")
  fit <- aov(y~Time*Group + Error(ID), data=DF)
  summary(fit)[[2]][[1]][2,5]
}
