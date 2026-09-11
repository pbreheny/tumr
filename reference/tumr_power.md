# Power calculation for tumor growth

Estimates power using simulated tumor growth data and a response-feature
analysis.

## Usage

``` r
tumr_power(n, effect_size, N = 1000, ...)
```

## Arguments

- n:

  Sample size per group.

- effect_size:

  Treatment effect size.

- N:

  Number of simulations. Default is 1000.

- ...:

  Additional arguments for data generation.

## Value

A data frame containing simulation settings and p-values.

## Examples

``` r
res <- tumr_power(8, 2, N = 10)
#>   |                                                                              |                                                                      |   0%  |                                                                              |=======                                                               |  10%  |                                                                              |==============                                                        |  20%  |                                                                              |=====================                                                 |  30%  |                                                                              |============================                                          |  40%  |                                                                              |===================================                                   |  50%  |                                                                              |==========================================                            |  60%  |                                                                              |=================================================                     |  70%  |                                                                              |========================================================              |  80%  |                                                                              |===============================================================       |  90%  |                                                                              |======================================================================| 100%
mean(res$p < 0.05)
#> [1] 0.9
```
