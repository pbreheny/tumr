# Creates Plots of an lmm object

Creates Plots of an lmm object

## Usage

``` r
# S3 method for class 'lmm'
plot(x, type = c("predict", "slope"), ...)
```

## Arguments

- x:

  lmm object

- type:

  Character string specifying which plot to produce. One of `"predict"`
  or `"slope"`.

- ...:

  further arguments passed to or from other methods

## Value

A list of ggplot objects.

## Examples

``` r
mel1 <- mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
mel1_lmm <- lmm(mel1)
#> Warning: Model failed to converge with max|grad| = 0.3043 (tol = 0.002, component 1)
#>   See ?lme4::convergence and ?lme4::troubleshooting.
plot(mel1_lmm, "predict")
#> Model has log1p-transformed response. Back-transforming predictions to
#>   original response scale. Standard errors are still on the transformed
#>   scale.

plot(mel1_lmm, "slope")
```
