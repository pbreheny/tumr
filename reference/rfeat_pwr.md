# Analysis based on response features

Analysis based on response features

## Usage

``` r
rfeat_pwr(Data, linear = TRUE)
```

## Arguments

- Data:

  From gendat

- linear:

  Assume linear growth?

## Value

A p-value

## Examples

``` r
dat <- gendat(5, 2, 6)
rfeat_pwr(dat)
#> [1] 0.05858826
```
