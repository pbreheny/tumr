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
#>  overall         1.06 0.125 32.9    0.804     1.31
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment months.trend    SE   df lower.CL upper.CL
#>  A                1.971 0.266 44.9    1.434    2.508
#>  B                0.677 0.226 24.1    0.210    1.144
#>  C                1.919 0.269 42.9    1.377    2.461
#>  D               -0.333 0.237 23.2   -0.823    0.158
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate    SE   df t.ratio p.value
#>  A - B      1.2941 0.349 33.8   3.703  0.0040
#>  A - C      0.0521 0.378 43.9   0.138  0.9991
#>  A - D      2.3036 0.357 32.6   6.457 <0.0001
#>  B - C     -1.2420 0.351 33.1  -3.534  0.0064
#>  B - D      1.0096 0.328 23.6   3.079  0.0250
#>  C - D      2.2516 0.359 32.0   6.278 <0.0001
#> 
#> Degrees-of-freedom method: kenward-roger 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
