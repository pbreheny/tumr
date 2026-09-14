# Creates Plots of an lmm object

Creates Plots of an lmm object

## Usage

``` r
# S3 method for class 'lmm'
plot(x, type = c("response", "slope"), ...)
```

## Arguments

- x:

  lmm object

- type:

  Character string specifying which plot to produce. One of `"response"`
  or `"slope"`.

- ...:

  further arguments passed to or from other methods

## Value

A list of ggplot objects.

## Examples

``` r
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
mel1_lmm <- lmm(mel1)
plot(mel1_lmm, "response")
#> Model has log1p-transformed response. Back-transforming predictions to
#>   original response scale. Standard errors are still on the transformed
#>   scale.

plot(mel1_lmm, "slope")
```
