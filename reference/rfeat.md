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
#> Error in rfeat(data = breast, id = "ID", time = "Week", measure = "Volume",     group = "Treatment", transformation = log1p, comparison = "t.test"): unused argument (transformation = log1p)
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
