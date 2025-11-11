# Analysis based on response features

Volume ~ Week \* Trt, separate function that picks apart this

## Usage

``` r
rfeat(
  tumr_obj = NULL,
  data = NULL,
  id = NULL,
  time = NULL,
  measure = NULL,
  group = NULL,
  transformation = NULL,
  comparison = c("t.test", "anova", "tukey", "both")
)
```

## Arguments

- tumr_obj:

  takes tumr_obj created by tumr()

- data:

  From gendat

- id:

  Column of subject ID's

- time:

  Column of repeated time measurements

- measure:

  Column of repeated measurements of tumor

- group:

  Column specifying the treatment group for each measurement

- transformation:

  transformation of measurement

- comparison:

  Takes "t.test", "anova", "tukey", or "both"

## Value

A p-value

## Details

exponential growth, separate packages

## Examples

``` r
data(breast)
rfeat(
data = breast,
id = "ID",
time = "Week",
measure = "Volume",
group = "Treatment",
transformation = log1p,
comparison = "t.test")
#> 
#>  Welch Two Sample t-test
#> 
#> data:  Beta by Group
#> t = 0.64605, df = 24.351, p-value = 0.5243
#> alternative hypothesis: true difference in means between group NR and group VEH is not equal to 0
#> 95 percent confidence interval:
#>  -0.3345751  0.6398147
#> sample estimates:
#>  mean in group NR mean in group VEH 
#>         0.8872739         0.7346541 
#> 
data(melanoma1)
rfeat(
data = melanoma1,
id = "ID",
time = "Day",
measure = "Volume",
group = "Treatment",
comparison = "anova")
#>             Df Sum Sq Mean Sq F value   Pr(>F)    
#> Group        3   4645  1548.3   35.62 3.64e-10 ***
#> Residuals   31   1347    43.5                     
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
