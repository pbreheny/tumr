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
#>  overall        0.986 0.142 33.9    0.698     1.27
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment months.trend    SE   df lower.CL upper.CL
#>  A                1.952 0.308 50.5    1.333    2.571
#>  B                0.664 0.250 22.8    0.147    1.181
#>  C                1.858 0.311 45.6    1.233    2.484
#>  D               -0.529 0.261 21.7   -1.070    0.013
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate    SE   df t.ratio p.value
#>  A - B      1.2886 0.397 35.6   3.248  0.0129
#>  A - C      0.0943 0.438 48.0   0.216  0.9964
#>  A - D      2.4809 0.404 34.0   6.143 <0.0001
#>  B - C     -1.1943 0.399 33.8  -2.996  0.0250
#>  B - D      1.1923 0.361 22.2   3.301  0.0158
#>  C - D      2.3866 0.406 32.4   5.882 <0.0001
#> 
#> Degrees-of-freedom method: kenward-roger 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
