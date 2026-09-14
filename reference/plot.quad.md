# Plot the result of Exponential quadratic model

Plots fitted treatment-specific quadratic growth curves or pairwise
treatment contrasts over time from a fitted `quad` object.

## Usage

``` r
# S3 method for class 'quad'
plot(x, type = c("predict", "contrast"), n_grid = 20, ...)
```

## Arguments

- x:

  An object of class `"quad"`.

- type:

  Type of plot to produce. Either `"predict"` for fitted
  treatment-specific growth curves or `"contrast"` for pairwise
  treatment contrasts over time. Default is `"predict"`.

- n_grid:

  Number of time points used to construct the fitted curves. Default is
  20.

- ...:

  Additional arguments passed to plotting functions.

## Value

A `ggplot` object.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
quad_obj <- quad(mel1)
plot(quad_obj, type = "predict")

plot(quad_obj, type = "contrast")

```
