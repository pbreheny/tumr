# Analysis based on response features

exponential growth, separate packages

## Usage

``` r
rfeat(
  tumr_obj = NULL,
  data = NULL,
  id = NULL,
  time = NULL,
  measure = NULL,
  group = NULL,
  log = TRUE,
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

- log:

  log transformation of measurement using log1p

- comparison:

  Takes "t.test", "anova", "tukey", or "both"

## Value

A p-value

## Examples

``` r
data(breast)
rfeat(
data = breast,
id = "ID",
time = "Week",
measure = "Volume",
group = "Treatment",
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
#>             Df  Sum Sq  Mean Sq F value   Pr(>F)    
#> Group        3 0.04132 0.013775    26.4 1.13e-08 ***
#> Residuals   31 0.01618 0.000522                     
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
