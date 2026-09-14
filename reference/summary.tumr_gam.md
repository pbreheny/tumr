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
#>  contrast   estimate        SE p.value
#>     A - B  5.5995408 0.7056964  0.0000
#>     A - C  0.0477361 0.7181460  0.9470
#>     A - D  7.3182799 0.7286342  0.0000
#>     B - C -5.5518047 0.7152382  0.0000
#>     B - D  1.7187391 0.7257685  0.0365
#>     C - D  7.2705438 0.7378795  0.0000
```
