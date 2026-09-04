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
