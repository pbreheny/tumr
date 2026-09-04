# Exponential quadratic Model for Tumor Growth Data

Fits an Exponential quadratic model for tumor growth data and computes
pairwise treatment contrasts over a grid of time points using estimated
marginal means.

## Usage

``` r
quad(
  tumr_obj = NULL,
  data = NULL,
  id = NULL,
  time = NULL,
  measure = NULL,
  group = NULL,
  n_grid = 20,
  ...
)
```

## Arguments

- tumr_obj:

  A `tumr` object created by
  [`tumr()`](https://pbreheny.github.io/tumr/reference/tumr.md).

- data:

  Tumor growth data. Only used if `tumr_obj` is not supplied.

- id:

  Column name for subject IDs.

- time:

  Column name for repeated time measurements.

- measure:

  Column name for tumor measurements.

- group:

  Column name specifying the treatment group.

- n_grid:

  Number of time points used to evaluate treatment contrasts. Default is
  20.

- ...:

  Further arguments passed to
  [`lme4::lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html).

## Value

An object of class `quad`, which is a list containing:

- data:

  The processed tumor growth data.

- fit:

  The fitted Exponential quadratic model.

- emm:

  Estimated marginal means by treatment at each time point.

- contrast_obj:

  Pairwise treatment contrasts.

- contrast_df:

  A data frame containing contrast estimates and confidence intervals.

## Examples

``` r
data(melanoma1)
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
#> Warning: 
#> --------------------------------------------------------------------
#> The time range is greater than 50, which may cause convergence
#> issues when fitting lmm(). Consider rescaling the time variable
#> to a larger unit (e.g., from days to weeks or months).
#> --------------------------------------------------------------------
quad_obj <- quad(mel1)
#> Warning: Some predictor variables are on very different scales: consider rescaling
#> Warning: Model failed to converge with max|grad| = 0.0608719 (tol = 0.002, component 1)
```
