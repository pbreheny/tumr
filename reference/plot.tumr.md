# Plot a tumr object

Plot a tumr object

## Usage

``` r
# S3 method for class 'tumr'
plot(x, ...)
```

## Arguments

- x:

  A tumr object created by
  [`tumr()`](https://pbreheny.github.io/tumr/reference/tumr.md).

- ...:

  Additional arguments passed to
  [`plot_median()`](https://pbreheny.github.io/tumr/reference/plot_median.md).

## Value

A ggplot object.

## Examples

``` r
data(melanoma2)
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
plot(mel2)

plot(mel2, par = FALSE)

plot(mel2, fold = TRUE)

plot(mel2, par = FALSE, fold = TRUE)

```
