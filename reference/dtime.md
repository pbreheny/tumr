# Tumor Doubling Time Based on Fitted Tumor Growth Model

Tumor Doubling Time Based on Fitted Tumor Growth Model

## Usage

``` r
dtime(x, seed = NULL, nsim = 1000)
```

## Arguments

- x:

  A fitted model object.

- seed:

  Random seed for reproducibility.

- nsim:

  Number of bootstrap simulations.

## Value

A list with three components:

- `method`: Character string describing the method used.

- `message`: Character string indicating that the model should
  demonstrate an exponential growth pattern.

- `summary`: A data frame summarizing tumor doubling time by treatment
  group, including mean, median, and 95% intervals.

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
