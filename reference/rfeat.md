# Analysis Based on Response Features

Analyze individual tumor growth rates and compare them across treatment
groups.

## Usage

``` r
rfeat(
  tumr_obj = NULL,
  log = TRUE,
  comparison = c("t.test", "anova", "tukey", "both")
)
```

## Arguments

- tumr_obj:

  A tumr object created by
  [`tumr()`](https://pbreheny.github.io/tumr/reference/tumr.md).

- log:

  Whether to apply log1p transformation to the tumor measurements.
  Default is TRUE.

- comparison:

  Statistical comparison method. One of "t.test", "anova", "tukey", or
  "both".

## Value

A list with four components:

- `relevant_information`: Variables used in the analysis.

- `betas`: Individual-level estimated slopes.

- `summary`: Average slope for each treatment group.

- `test`: Results of the selected statistical test.

## Examples

``` r
data(breast)
breast_obj <- tumr(breast, ID, Week, Volume, Treatment)
rfeat(breast_obj, comparison = "t.test")
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
melanoma_obj <- tumr(melanoma1, ID, Day, Volume, Treatment)
#> Warning: 
#> --------------------------------------------------------------------
#> The time range is greater than 50, which may cause convergence
#> issues when fitting lmm(). Consider rescaling the time variable
#> to a larger unit (e.g., from days to weeks or months).
#> --------------------------------------------------------------------
rfeat(melanoma_obj, comparison = "anova")
#>             Df  Sum Sq  Mean Sq F value   Pr(>F)    
#> Group        3 0.04132 0.013775    26.4 1.13e-08 ***
#> Residuals   31 0.01618 0.000522                     
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
```
