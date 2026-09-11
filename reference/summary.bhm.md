# Creates a summary of a bhm object

Creates a summary of a bhm object

## Usage

``` r
# S3 method for class 'bhm'
summary(object, ...)
```

## Arguments

- object:

  bhm object

- ...:

  further arguments passed to or from other methods

## Value

a list containing posterior summaries on log scale and exp scale

## Examples

``` r
if (FALSE) { # \dontrun{
data(melanoma2)
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
fit <- bhm(mel2)
summary(fit)
} # }
```
