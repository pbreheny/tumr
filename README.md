# tumr

<!-- badges: start -->
[![GitHub version](https://img.shields.io/static/v1?label=GitHub&message=0.7.0&color=blue&logo=github)](https://github.com/pbreheny/tumr)
[![R-CMD-check](https://github.com/pbreheny/tumr/workflows/R-CMD-check/badge.svg)](https://github.com/pbreheny/tumr/actions)
<!-- badges: end -->

tumr is a collection of tools for analyzing tumor growth data. 

An example of how to use tumr can be seen in the [Get Started](https://pbreheny.github.io/tumr/articles/tumr.html) page.


## How to install tumr

To install tumr, copy and paste the following code into the console

```
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("pbreheny/tumr")
```


## Minimal Example

``` r
library(tumr)
data("melanoma2")

# Create a tumr object
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)

# Visualization
plot_median(mel2, par = FALSE)
plot_median(mel2, par = FALSE)
plot_median(mel2, par = TRUE)
plot_median(mel2, par = TRUE, fold = TRUE)

# Response feature analysis
rfeat_mel2 <- rfeat(mel2, comparison = "both")
plot(rfeat_mel2)

# Fit linear-mixed model
lmm_mel2 <- lmm(mel2)
summary(lmm_mel2)
plot(lmm_mel2, "response")
plot(lmm_mel2, "response") + ggplot2::scale_y_log10()
plot(lmm_mel2, "slope")

# Fit non-linear model - quadratic
quad_obj <- quad(mel2)
plot(quad_obj)

# Fit non-linear model - Generalized Addictive Mixed Model
fit <- gamFit(mel2)
plot(fit, "predict") + ggplot2::scale_y_log10()
plot(fit, "contrast")

# Fit Bayesian Hierarchical Linear Model
fit_bhm <- bhm(melanoma2)
summary(fit_bhm)
plot(fit_bhm, type = "predict")
plot(fit_bhm, type = "slope")
plot(fit_bhm, type = "contrast")
plot(fit_bhm, type = "contrast") +
  ggplot2::scale_x_continuous(
    labels = function(z) scales::number(exp(z), 0.01)
  )
plot(fit_bhm, type = "trace")

# Compute Tumor Doubling Time
dtime(lmm_mel2)
dtime(fit_bhm)

```