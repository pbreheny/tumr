# Creates plots for a bhm object

Produces interval plots for treatment-specific slopes and slope
contrasts based on the posterior summaries returned by
[`summary()`](https://rdrr.io/r/base/summary.html).

## Usage

``` r
# S3 method for class 'bhm'
plot(x, ...)
```

## Arguments

- x:

  A `bhm` object returned by
  [`bhm()`](https://pbreheny.github.io/tumr/reference/bhm.md).

- ...:

  Further arguments passed to or from other methods (currently unused).

## Value

Invisibly returns a list with two ggplot objects: `slope_each_plot` and
`slope_diff_plot`.

## Examples

``` r
data("melanoma1")
fit <- bhm(melanoma1)
#> Error: Model not compiled. Try running the compile() method first.
plot(fit)
#> Error: object 'fit' not found
```
