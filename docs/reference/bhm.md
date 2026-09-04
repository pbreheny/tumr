# Bayesian hierarchical linear model and options with censoring

Bayesian hierarchical linear model and options with censoring

## Usage

``` r
bhm(data, cens = NULL, diagnostics = FALSE, return_fit = TRUE, ...)
```

## Arguments

- data:

  data.frame with columns ID, Day, Volume, Treatment

- cens:

  Optional numeric scalar. If provided, observations with
  `log1p(Volume) <= cens` are treated as left-censored at `cens`. Set
  `cens = NULL` (default) to fit the non-censored model.

- diagnostics:

  logical; whether to return diagnostic summary

- return_fit:

  logical; whether to return the CmdStan fit object

- ...:

  further arguments

## Value

A list of posterior summaries (and optionally diagnostics / fit)

## Examples

``` r
if (FALSE) { # \dontrun{
data(melanoma2)
fit <- bhm(melanoma2)
fit_cens <- bhm(melanoma2, cens = log1p(10))
} # }
```
