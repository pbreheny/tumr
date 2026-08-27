# Plot Quadratic Linear Mixed Model Fit

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
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
quad_obj <- quad(mel1)
#> Warning: Some predictor variables are on very different scales: consider rescaling. 
#> You may also use (g)lmerControl(autoscale = TRUE) to improve numerical stability.
#> Warning: Model failed to converge with max|grad| = 0.0175242 (tol = 0.002, component 1)
#>   See ?lme4::convergence and ?lme4::troubleshooting.

# Fitted quadratic growth curves
plot(quad_obj, type = "predict")
#> Warning: the ‘nobars’ function has moved to the reformulas package. Please update your imports, or ask an upstream package maintainer to do so.

# Pairwise treatment contrasts over time
plot(quad_obj, type = "contrast")

```
