# Bayesian hierarchical model for tumor growth Fits a Bayesian hierarchical linear model to longitudinal tumor volume data on the `log1p(Volume)` scale, allowing treatment-specific population intercepts and slopes and subject-specific random intercept/slope.

Optionally supports left-censoring at a user-specified cutoff `cens` on
the same scale as `y = log1p(Volume)`.

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
fit
} # }
```
