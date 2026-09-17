# Exponential quadratic Model for Tumor Growth Data

Fits an Exponential quadratic model for tumor growth data and computes
pairwise treatment contrasts over a grid of time points using estimated
marginal means.

## Usage

``` r
quad(tumr_obj = NULL, n_grid = 20, ...)
```

## Arguments

- tumr_obj:

  A `tumr` object created by
  [`tumr()`](https://pbreheny.github.io/tumr/reference/tumr.md).

- n_grid:

  Number of time points used to evaluate treatment contrasts. Default is
  20.

- ...:

  Further arguments passed to
  [`lme4::lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html).

## Value

An object of class `quad` containing the fitted model, estimated
marginal means, and pairwise treatment contrasts.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
quad_obj <- quad(mel1)
```
