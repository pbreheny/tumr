# tumr

## tumr ![](man/Figures/logo.png)

tumr is a collection of tools for visualizing and analyzing tumor growth
data.

An example of how to use tumr can be seen in the [Get
Started](https://pbreheny.github.io/tumr/articles/tumr.html) page.

## How to install tumr

Using `tumr` package requires installing the R package
[`cmdstanr`](https://mc-stan.org/cmdstanr/) (not available on CRAN) and
the command-line interface to Stan:
[`CmdStan`](https://mc-stan.org/users/interfaces/cmdstan.html). You may
follow the instructions in [Getting started with
CmdStanR](https://mc-stan.org/cmdstanr/articles/cmdstanr.html) to
install both.

To install tumr, copy and paste the following code into the console

    if (!requireNamespace("remotes")) install.packages("remotes")
    remotes::install_github("pbreheny/tumr")

## Minimal Example

``` r

library(tumr)
data("melanoma2")

# Create a tumr object
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)

# Visualization
plot(mel2, par = FALSE)
plot(mel2, par = FALSE)
plot(mel2, par = TRUE)
plot(mel2, par = TRUE, fold = TRUE)

# Response feature analysis
rfeat_mel2 <- rfeat(mel2, comparison = "both")
plot(rfeat_mel2)

# Linear mixed-effects modeling
lmm_mel2 <- lmm(mel2)
summary(lmm_mel2)
plot(lmm_mel2, "response")
plot(lmm_mel2, "response") + ggplot2::scale_y_log10()
plot(lmm_mel2, "slope")

# Nonlinear model - Exponential quadratic model
quad_obj <- quad(mel2)
plot(quad_obj, "predict") + ggplot2::scale_y_log10()
plot(quad_obj, "contrast")

# Nonlinear model - Generalized Addictive Model
fit <- gamFit(mel2)
plot(fit, "predict") + ggplot2::scale_y_log10()
plot(fit, "contrast")

# Bayesian Hierarchical Linear Model
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
