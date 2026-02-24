# Creates plots for a bhm object

Produces interval plots for treatment-specific slopes, slope contrasts,
or MCMC trace plots based on posterior summaries returned by
[`summary()`](https://rdrr.io/r/base/summary.html).

## Usage

``` r
# S3 method for class 'bhm'
plot(x, type = c("predict", "slope", "contrast", "trace"), ...)
```

## Arguments

- x:

  A `bhm` object returned by
  [`bhm()`](https://pbreheny.github.io/tumr/reference/bhm.md).

- type:

  Character string specifying which plot to produce. One of `"slope"`,
  `"contrast"`, or `"trace"`.

- ...:

  Further arguments passed to trace plotting functions (currently used
  only when `type = "trace"`).

## Value

If `type` is `"predict"`, `"slope"`, or `"contrast"`, returns a `ggplot`
object. If `type` is `"trace"`, returns a list of `ggplot` objects with
elements `trace_intercept`, `trace_slope`, and `trace_slope_diff`.

## Examples

``` r
if (FALSE) { # \dontrun{
data("melanoma1")
fit <- bhm(melanoma1)
plot(fit, type = "predict")
plot(fit, type = "slope")
plot(fit, type = "contrast")
plot(fit, type = "contrast") +
  ggplot2::scale_x_continuous(
    transform = "exp",
    labels = function(z) sprintf("%.2f", exp(z))
  )
plot(fit, type = "trace")
} # }
```
