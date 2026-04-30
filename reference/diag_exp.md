# Diagnostic plots for exponential growth assumption

Diagnostic plots for exponential growth assumption

## Usage

``` r
diag_exp(lmm_obj, type = c("time", "fitted", "qq"))
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
