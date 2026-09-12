# tumr

## tumr ![](reference/figures/logo.png)

tumr is a collection of tools for visualizing and analyzing tumor growth
data.

An example of how to use tumr can be seen in the [Get
Started](https://pbreheny.github.io/tumr/articles/tumr.html) page.

## How to install tumr

To install tumr, copy and paste the following code into the console

    if (!requireNamespace("remotes")) install.packages("remotes")
    remotes::install_github("pbreheny/tumr")

## Minimal Example

``` r

library(tumr)
data("melanoma2")

# Create a tumr object (Both quoted and unquoted names are supported.)
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
mel2 <- tumr(melanoma2, "ID", "months", "Volume", "Treatment")

# Visualization (Original scale and Log scale)
plot(mel2, par = TRUE)
plot(mel2, par = TRUE, fold = TRUE)
plot(mel2, par = TRUE) + ggplot2::scale_y_log10()
plot(mel2, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()

# Response feature analysis
rfeat_mel2 <- rfeat(mel2, comparison = "both")
plot(rfeat_mel2)

# Linear mixed-effects modeling
lmm_obj <- lmm(mel2)
summary(lmm_obj)
plot(lmm_obj, "response")
plot(lmm_obj, "response") + ggplot2::scale_y_log10()
plot(lmm_obj, "slope")

# Nonlinear model - Exponential quadratic model
quad_obj <- quad(mel2)
plot(quad_obj, "predict") + ggplot2::scale_y_log10()
plot(quad_obj, "contrast")

# Nonlinear model - Generalized Addictive Model
gam_obj <- tumr_gam(mel2)
plot(gam_obj, "predict") + ggplot2::scale_y_log10()
plot(gam_obj, "contrast")

# Compute Tumor Doubling Time based on Linear mixed-effects modeling
dtime(lmm_obj)
```
