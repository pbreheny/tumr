# Plot tumor volume or fold change over time

Plot tumor volume or fold change over time

## Usage

``` r
# S3 method for class 'tumr'
plot(x, par = TRUE, fold = FALSE, lld = NULL, ...)
```

## Arguments

- x:

  A `tumr` object created by
  [`tumr()`](https://pbreheny.github.io/tumr/reference/tumr.md).

- par:

  Logical. If TRUE, use parametric median estimation. If FALSE, use
  nonparametric Kaplan-Meier estimation.

- fold:

  Logical. If TRUE, plot fold change instead of raw volume.

- lld:

  Optional lower limit of detection used to replace zero values. If
  NULL, the lower limit is calculated using
  [`get_limit()`](https://pbreheny.github.io/tumr/reference/get_limit.md).

- ...:

  Additional arguments.

## Value

A ggplot object

## Examples

``` r
data(melanoma2)
melanoma2$months <- melanoma2$Day / (365 / 12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
plot(mel2)

plot(mel2, par = FALSE)

plot(mel2, fold = TRUE)

plot(mel2, par = FALSE, fold = TRUE)

```
