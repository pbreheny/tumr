# Calculate the Lower Detection Limit

Calculates a lower detection limit based on the smallest nonzero
observed tumor volume. The limit is defined as one-half of the minimum
nonzero `Volume` value in the data.

## Usage

``` r
get_limit(x)
```

## Arguments

- x:

  The tumr object.

## Value

A numeric value as the lower detection limit.

## Examples

``` r
data(melanoma1)
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
get_limit(mel1)
#> [1] 2.65
```
