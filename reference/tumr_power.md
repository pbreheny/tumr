# Power calculation for tumor growth

For speed, uses a response feature analysis
[`rfeat()`](https://pbreheny.github.io/tumr/reference/rfeat.md); this
will likely underestimate power somewhat.

## Usage

``` r
tumr_power(n, effect_size, N = 1000, ...)
```

## Arguments

- n:

  Sample size per group (integer or vector)

- effect_size:

  As in
  [`gendat()`](https://pbreheny.github.io/tumr/reference/gendat.md)
  (numeric or vector)

- N:

  Number of simulations (default: 1000)

- ...:

  Other arguments to
  [`gendat()`](https://pbreheny.github.io/tumr/reference/gendat.md)

## Value

An array of p-values

## Examples

``` r
res <- tumr_power(8, 2, 10)
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======                                                               |  10%  |                                                                              |==============                                                        |  20%  |                                                                              |=====================                                                 |  30%  |                                                                              |============================                                          |  40%  |                                                                              |===================================                                   |  50%  |                                                                              |==========================================                            |  60%  |                                                                              |=================================================                     |  70%  |                                                                              |========================================================              |  80%  |                                                                              |===============================================================       |  90%  |                                                                              |======================================================================| 100%
mean(res$p < 0.05)
#> [1] 0.9
```
