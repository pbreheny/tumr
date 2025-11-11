# Linear Mixed Model for Tumor Growth Data

Linear Mixed Model for Tumor Growth Data

## Usage

``` r
lmm(
  tumr_obj = NULL,
  formula = NULL,
  data = NULL,
  id = NULL,
  time = NULL,
  measure = NULL,
  group = NULL,
  ...
)
```

## Arguments

- tumr_obj:

  takes tumr_obj created by tumr()

- formula:

  linear mixed model formula

- data:

  tumor growth data

- id:

  Column of subject ID's

- time:

  Column of repeated time measurements

- measure:

  Column of repeated measurements of tumor

- group:

  Column specifying the treatment group for each measurement

- ...:

  Further arguments to
  [`lme4::lmer()`](https://rdrr.io/pkg/lme4/man/lmer.html)

## Value

summary of linear mixed model fit

## Examples

``` r
data(melanoma1)
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
lmm(mel1)
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: log1p(Volume) ~ Treatment * scale(Day) + (scale(Day) | ID)
#>    Data: data
#> 
#> REML criterion at convergence: 2028.9
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -2.7387 -0.4428  0.0883  0.5192  3.2744 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr
#>  ID       (Intercept) 1.3872   1.1778       
#>           scale(Day)  0.7463   0.8639   0.97
#>  Residual             1.4535   1.2056       
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>                       Estimate Std. Error      df t value Pr(>|t|)    
#> (Intercept)             7.1736     0.4429 41.2795  16.197  < 2e-16 ***
#> TreatmentB             -4.3047     0.5987 34.8445  -7.190 2.23e-08 ***
#> TreatmentC             -0.3122     0.6309 41.8851  -0.495  0.62331    
#> TreatmentD             -5.7652     0.6146 34.3159  -9.380 5.34e-11 ***
#> scale(Day)              2.3725     0.3740 59.2521   6.343 3.41e-08 ***
#> TreatmentB:scale(Day)  -1.5660     0.4815 41.9847  -3.252  0.00226 ** 
#> TreatmentC:scale(Day)  -0.1146     0.5295 56.5919  -0.216  0.82944    
#> TreatmentD:scale(Day)  -3.0148     0.4904 40.1877  -6.148 2.87e-07 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtmnB TrtmnC TrtmnD scl(D) TB:(D) TC:(D)
#> TreatmentB  -0.740                                          
#> TreatmentC  -0.702  0.519                                   
#> TreatmentD  -0.721  0.533  0.506                            
#> scale(Day)   0.898 -0.664 -0.630 -0.647                     
#> TrtmntB:(D) -0.697  0.895  0.489  0.502 -0.777              
#> TrtmntC:(D) -0.634  0.469  0.901  0.457 -0.706  0.549       
#> TrtmntD:(D) -0.685  0.507  0.481  0.897 -0.763  0.593  0.539

lmm(
tumr_obj = mel1,
formula = "Volume ~ Day + (1 | ID)"
)
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: Volume ~ Day + (1 | ID)
#>    Data: data
#> 
#> REML criterion at convergence: 8821.3
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -1.5481 -0.5180 -0.1911  0.2727  7.0346 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  ID       (Intercept)  90118   300.2   
#>  Residual             125177   353.8   
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>             Estimate Std. Error      df t value Pr(>|t|)    
#> (Intercept)  127.342     56.728  42.665   2.245     0.03 *  
#> Day            3.665      0.435 584.726   8.427 2.77e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>     (Intr)
#> Day -0.351

data(breast)
lmm(
data = breast,
id = "ID",
group = "Treatment",
time = "Week",
measure = "Volume"
)
#> boundary (singular) fit: see help('isSingular')
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: log1p(Volume) ~ Treatment * scale(Week) + (scale(Week) | ID)
#>    Data: data
#> 
#> REML criterion at convergence: 1420.4
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.55645 -0.38793  0.01296  0.56081  2.09235 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr
#>  ID       (Intercept) 5.577    2.362        
#>           scale(Week) 4.390    2.095    1.00
#>  Residual             3.808    1.951        
#> Number of obs: 319, groups:  ID, 28
#> 
#> Fixed effects:
#>                          Estimate Std. Error      df t value Pr(>|t|)    
#> (Intercept)                3.0986     0.6502 25.6306   4.766 6.45e-05 ***
#> TreatmentVEH              -0.4747     0.9206 25.7558  -0.516    0.611    
#> scale(Week)                3.0499     0.5829 25.4085   5.233 1.95e-05 ***
#> TreatmentVEH:scale(Week)  -0.5515     0.8265 25.6620  -0.667    0.511    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtVEH scl(W)
#> TreatmntVEH -0.706              
#> scale(Week)  0.939 -0.663       
#> TrtmVEH:(W) -0.662  0.939 -0.705
#> optimizer (nloptwrap) convergence code: 0 (OK)
#> boundary (singular) fit: see help('isSingular')
#> 
```
