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
#> Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed
#> Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed
#> $`overall effect of time`
#>  1       Day.trend      SE   df lower.CL upper.CL
#>  overall    0.0324 0.00466 39.4    0.023   0.0418
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: satterthwaite 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment Day.trend      SE   df lower.CL upper.CL
#>  A            0.0642 0.01010 58.0  0.04388 0.084443
#>  B            0.0217 0.00822 26.7  0.00485 0.038618
#>  C            0.0611 0.01020 53.0  0.04077 0.081522
#>  D           -0.0174 0.00860 25.3 -0.03508 0.000318
#> 
#> Degrees-of-freedom method: satterthwaite 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate     SE   df t.ratio p.value
#>  A - B     0.04243 0.0130 41.2   3.252  0.0118
#>  A - C     0.00302 0.0143 55.5   0.210  0.9967
#>  A - D     0.08154 0.0133 39.4   6.136  <.0001
#>  B - C    -0.03941 0.0131 39.4  -3.015  0.0223
#>  B - D     0.03911 0.0119 25.9   3.287  0.0145
#>  C - D     0.07852 0.0133 37.8   5.899  <.0001
#> 
#> Degrees-of-freedom method: satterthwaite 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
