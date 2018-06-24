mixed <- function(Data) {
  df <- array2df(Data$Y, c("ID", "Time", "Group", "y"))
  df$ID <- paste(df$Group, df$ID, sep="-")
  df$Time <- factor2num(df$Time)
  require(lme4)
  fit <- lmer(y~Time + Time:Group + (0+Time|ID), data=df)
  tval <- summary(fit)$coef[3,3]
  n <- dim(Data$Y)[1]
  g <- dim(Data$Y)[3]
  ##2*pnorm(abs(tval), lower=FALSE)
  df <- n*g - 3
  2*pt(abs(tval), df, lower=FALSE)
}
