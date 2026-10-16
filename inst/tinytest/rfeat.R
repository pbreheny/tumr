if (interactive()) library(tinytest)

# Simulated data: 6 subjects (M1-M6), 4 time points, 2 groups
set.seed(1)
dat <- expand.grid(Time = 0:3, ID = paste0("M", 1:6), stringsAsFactors = FALSE)
dat$Group <- rep(c("A", "B"), each = 12)
dat$Volume <- exp(0.1 * dat$Time + rnorm(nrow(dat), 0, 0.1))

# Subjects with < 2 observations should be dropped, not left as placeholder rows
short <- rbind(dat, data.frame(Time = 0, ID = "M7", Group = "A", Volume = 1))
fit <- rfeat(data = short, id = "ID", time = "Time", measure = "Volume",
             group = "Group", comparison = "anova")
expect_equal(nrow(fit$betas), 6)
expect_false(any(fit$betas$Group == ""))
expect_equal(sort(fit$summary$Group), c("A", "B"))
expect_silent(rfeat(data = short, id = "ID", time = "Time", measure = "Volume",
                    group = "Group", comparison = "t.test"))

# Factor IDs should be reported as their labels, not integer codes
fdat <- dat
fdat$ID <- factor(fdat$ID)
fit <- rfeat(data = fdat, id = "ID", time = "Time", measure = "Volume",
             group = "Group")
expect_equal(as.character(fit$betas$ID), paste0("M", 1:6))
