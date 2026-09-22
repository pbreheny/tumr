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
#> Warning: optimx: No match to available methods
#> Warning: Default method when bounds specified is L-BFGS-B to match optim()
#> boundary (singular) fit: see help('isSingular')
#> Warning: Model failed to converge with 1 negative eigenvalue: -2.8e+00
summary(mel1_lmm)
#> $`overall effect of time`
#>  1       months.trend   SE   df lower.CL upper.CL
#>  overall         1.05 0.12 33.7    0.807      1.3
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment months.trend    SE   df lower.CL upper.CL
#>  A                1.974 0.258 47.6    1.456    2.492
#>  B                0.680 0.216 24.1    0.235    1.125
#>  C                1.886 0.259 43.9    1.364    2.408
#>  D               -0.332 0.226 23.2   -0.800    0.135
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate    SE   df t.ratio p.value
#>  A - B      1.2944 0.336 35.0   3.851  0.0026
#>  A - C      0.0881 0.366 45.7   0.241  0.9950
#>  A - D      2.3064 0.343 33.8   6.726 <0.0001
#>  B - C     -1.2063 0.337 33.6  -3.578  0.0057
#>  B - D      1.0120 0.312 23.6   3.239  0.0174
#>  C - D      2.2184 0.344 32.5   6.451 <0.0001
#> 
#> Degrees-of-freedom method: kenward-roger 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
