# Bayesian Hierarchical Linear Model for Tumor Growth Data

Bayesian Hierarchical Linear Model for Tumor Growth Data

## Usage

``` r
bhm(tumr_obj, cens = NULL, diagnostics = FALSE, return_fit = TRUE, ...)
```

## Arguments

- tumr_obj:

  A `tumr` object created by
  [`tumr`](https://pbreheny.github.io/tumr/reference/tumr.md).

- cens:

  Optional numeric scalar. If provided, observations with
  `log1p(measure) <= cens` are treated as left-censored at `cens`. Set
  `cens = NULL` (default) to fit the non-censored model.

- diagnostics:

  Logical; whether to return diagnostic summaries.

- return_fit:

  Logical; whether to return the CmdStan fit object.

- ...:

  Further arguments passed to the CmdStan sampling method.

## Value

An object of class `"bhm"` containing posterior summaries and optionally
diagnostics and the CmdStan fit.

## Examples

``` r
if (FALSE) { # \dontrun{
data(melanoma2)
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
fit <- bhm(mel2)
fit_cens <- bhm(mel2, cens = log1p(10))
} # }
```
