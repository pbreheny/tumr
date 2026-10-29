# Creates a summary of an lmm object

Creates a summary of an lmm object

## Usage

``` r
# S3 method for class 'lmm'
summary(object, ...)
```

## Arguments

- object:

  lmm object

- ...:

  further arguments passed to or from other methods

## Value

a summary of the lmm object

## Examples

``` r
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
mel1_lmm <- lmm(mel1)
summary(mel1_lmm)
#> $`overall effect of time`
#>  1       months.trend    SE   df lower.CL upper.CL
#>  overall         1.06 0.125 37.4    0.805     1.31
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: satterthwaite 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment months.trend    SE   df lower.CL upper.CL
#>  A                1.971 0.266 50.7    1.437    2.505
#>  B                0.677 0.226 27.4    0.213    1.141
#>  C                1.919 0.268 48.8    1.381    2.457
#>  D               -0.333 0.237 26.4   -0.820    0.155
#> 
#> Degrees-of-freedom method: satterthwaite 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate    SE   df t.ratio p.value
#>  A - B      1.2941 0.349 38.4   3.706  0.0036
#>  A - C      0.0521 0.377 49.7   0.138  0.9990
#>  A - D      2.3036 0.357 37.0   6.461 <0.0001
#>  B - C     -1.2420 0.350 37.7  -3.545  0.0056
#>  B - D      1.0096 0.328 26.9   3.080  0.0231
#>  C - D      2.2516 0.358 36.4   6.296 <0.0001
#> 
#> Degrees-of-freedom method: satterthwaite 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
