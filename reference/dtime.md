# Tumor Doubling Time Based on Fitted Tumor Growth Model

Tumor Doubling Time Based on Fitted Tumor Growth Model

## Usage

``` r
dtime(x)
```

## Arguments

- x:

  A fitted model object.

## Value

A list with three components:

- `method`: character string describing the method used.

- `message`: character string indicating that the model should
  demonstrate an exponential growth pattern.

- `summary`: a data frame summarizing tumor doubling time by treatment
  group, including mean, median, and 95\\

## Examples

``` r
if (FALSE) { # \dontrun{
data(melanoma2)
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
fit_bhm <- bhm(mel2)
dtime(fit_bhm)
fit_lmm <- lmm(mel2)
dtime(fit_lmm)
} # }
```
