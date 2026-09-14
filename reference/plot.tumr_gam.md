# Plot GAM Fit for Tumor Growth Data

Plot GAM Fit for Tumor Growth Data

## Usage

``` r
# S3 method for class 'tumr_gam'
plot(x, type = c("predict", "contrast"), n_grid = NULL, ...)
```

## Arguments

- x:

  An object of class `"tumr_gam"`.

- type:

  Either `"predict"` (fitted curves per group) or `"contrast"` (pairwise
  differences over time).

- n_grid:

  Number of time grid points. Defaults to `x$n_grid`.

- ...:

  Currently ignored.

## Value

A `ggplot` object.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
fit_gam <- tumr_gam(mel1)
plot(fit_gam, "predict")

plot(fit_gam, "contrast")

```
