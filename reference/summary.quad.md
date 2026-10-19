# Creates a summary of a quad object

Returns the full linear mixed-model summary and pairwise treatment
comparisons based on estimated marginal means.

## Usage

``` r
# S3 method for class 'quad'
summary(object, ...)
```

## Arguments

- object:

  An object of class `"quad"`.

- ...:

  Currently ignored.

## Value

An object of class `"summary.quad"` containing:

- `model_summary`: Full summary of the fitted linear mixed model.

- `pairwise_tests`: Pairwise treatment comparisons with Holm-adjusted
  p-values.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
fit_quad <- quad(mel1)
summary(fit_quad)
#> NOTE: Results may be misleading due to involvement in interactions
#>  contrast   estimate        SE p.value
#>     A - B  4.8419694 0.5524632  0.0000
#>     A - C  0.2878099 0.5627077  0.6122
#>     A - D  5.9225040 0.5686982  0.0000
#>     B - C -4.5541595 0.5529279  0.0000
#>     B - D  1.0805346 0.5590232  0.1253
#>     C - D  5.6346941 0.5691497  0.0000
```
