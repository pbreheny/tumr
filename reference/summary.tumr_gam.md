# Summary of a GAM Fit for Tumor Growth Data

Returns the full `mgcv` GAM summary and pairwise group comparisons via
`emmeans::pairs()`.

## Usage

``` r
# S3 method for class 'tumr_gam'
summary(object, ...)
```

## Arguments

- object:

  An object of class `"tumr_gam"`.

- ...:

  Currently ignored.

## Value

An object of class `"summary.tumr_gam"` with components:

- `gam_summary`:

  Full
  [`mgcv::summary.gam`](https://rdrr.io/pkg/mgcv/man/summary.gam.html)
  output.

- `pairwise_tests`:

  Data frame of pairwise Wald test results with adjusted p-values.

- `relevant_info`:

  Column name metadata.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
fit <- tumr_gam(mel1)
summary(fit)
#>  contrast    estimate        SE p.value
#>     A - B  4.94021481 0.6216152  0.0000
#>     A - C  0.01675351 0.6329712  0.9789
#>     A - D  6.29711932 0.6400391  0.0000
#>     B - C -4.92346130 0.6302455  0.0000
#>     B - D  1.35690452 0.6373436  0.0674
#>     C - D  6.28036581 0.6484241  0.0000
```
