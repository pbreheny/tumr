rmanova <- function(Data) {
  df <- array2df(Data$Y, c("ID", "Time", "Group", "y"))
  df$ID <- paste(df$Group, df$ID, sep="-")
  fit <- aov(y~Time*Group + Error(ID), data=df)
  summary(fit)[[2]][[1]][2,5]
}