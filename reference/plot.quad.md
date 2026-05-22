# Plot Quadratic Linear Mixed Model Treatment Contrasts

Plots pairwise treatment contrasts over time from a fitted `quad`
object.

## Usage

``` r
# S3 method for class 'quad'
plot(x, ...)
```

## Arguments

- x:

  An object of class `quad`.

- ...:

  Additional arguments passed to plotting functions.

## Value

A `ggplot` object.

## Examples

``` r
data(melanoma1)
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
quad_obj <- quad(mel1)
plot(quad_obj)

```
