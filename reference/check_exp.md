# Diagnostic plots for exponential growth assumption

Diagnostic plots for exponential growth assumption

## Usage

``` r
check_exp(lmm_obj, type = c("time", "fitted", "qq"))
```

## Arguments

- lmm_obj:

  An lmm object created by lmm().

- type:

  Diagnostic plot type. Options are: "time" for residuals vs time,
  "fitted" for residuals vs fitted values, "qq" for QQ plot of
  residuals.

## Value

A ggplot object.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
lmm1 <- lmm(mel1)
check_exp(lmm1)
#> `geom_smooth()` using formula = 'y ~ x'

```
