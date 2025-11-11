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
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
mel1_lmm <- lmm(mel1)
#> Warning: Model failed to converge with max|grad| = 0.3043 (tol = 0.002, component 1)
summary(mel1_lmm)
#> $`overall effect of time`
#>  1       Day.trend      SE   df lower.CL upper.CL
#>  overall    0.0324 0.00467 33.8   0.0229   0.0419
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment Day.trend      SE   df lower.CL upper.CL
#>  A            0.0642 0.01010 50.2   0.0438 0.084541
#>  B            0.0217 0.00823 22.8   0.0047 0.038767
#>  C            0.0611 0.01020 45.6   0.0405 0.081744
#>  D           -0.0174 0.00860 21.7  -0.0352 0.000469
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate     SE   df t.ratio p.value
#>  A - B     0.04243 0.0131 35.4   3.248  0.0130
#>  A - C     0.00302 0.0144 47.8   0.210  0.9967
#>  A - D     0.08154 0.0133 33.9   6.131  <.0001
#>  B - C    -0.03941 0.0131 33.7  -3.001  0.0247
#>  B - D     0.03911 0.0119 22.2   3.286  0.0164
#>  C - D     0.07852 0.0134 32.4   5.875  <.0001
#> 
#> Degrees-of-freedom method: kenward-roger 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
