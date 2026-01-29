# Bayesian hierarchical model for tumor growth

Bayesian hierarchical model for tumor growth

## Usage

``` r
bhm(data, diagnostics = FALSE, return_fit = TRUE, ...)
```

## Arguments

- data:

  data.frame with columns ID, Day, Volume, Treatment

- diagnostics:

  logical; whether to return diagnostic summary

- return_fit:

  logical; whether to return the CmdStan fit object

- ...:

  further arguments passed to CmdStanR \$sample()

## Value

A list of posterior summaries (and optionally diagnostics / fit)
