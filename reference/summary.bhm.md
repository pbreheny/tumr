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
data(melanoma2)
fit <- bhm(melanoma2)
#> Error: Model not compiled. Try running the compile() method first.
summary(fit)
#> Error: object 'fit' not found
```
