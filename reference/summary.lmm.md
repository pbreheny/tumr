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
summary(mel1_lmm)
#> $`overall effect of time`
#>  1       Day.trend      SE   df lower.CL upper.CL
#>  overall    0.0324 0.00466 33.9    0.023   0.0419
#> 
#> Results are averaged over the levels of: Treatment 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`slope of treatment over time`
#>  Treatment Day.trend      SE   df lower.CL upper.CL
#>  A            0.0642 0.01010 50.5  0.04384  0.08454
#>  B            0.0218 0.00821 22.8  0.00483  0.03881
#>  C            0.0611 0.01020 45.6  0.04052  0.08165
#>  D           -0.0174 0.00858 21.7 -0.03518  0.00043
#> 
#> Degrees-of-freedom method: kenward-roger 
#> Confidence level used: 0.95 
#> 
#> $`test slope differences`
#>  contrast estimate     SE   df t.ratio p.value
#>  A - B      0.0424 0.0130 35.6   3.248  0.0129
#>  A - C      0.0031 0.0144 48.0   0.215  0.9964
#>  A - D      0.0816 0.0133 34.0   6.143  <.0001
#>  B - C     -0.0393 0.0131 33.8  -2.996  0.0250
#>  B - D      0.0392 0.0119 22.2   3.301  0.0158
#>  C - D      0.0785 0.0133 32.4   5.882  <.0001
#> 
#> Degrees-of-freedom method: kenward-roger 
#> P value adjustment: tukey method for comparing a family of 4 estimates 
#> 
```
