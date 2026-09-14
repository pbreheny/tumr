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
melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
lmm(mel1)
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: log1p(Volume) ~ Treatment * months + (months | ID)
#>    Data: data
#> 
#> REML criterion at convergence: 2030.5
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -2.7387 -0.4428  0.0883  0.5192  3.2744 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr  
#>  ID       (Intercept) 0.08055  0.2838         
#>           months      0.50534  0.7109   -0.29 
#>  Residual             1.45355  1.2056         
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>                   Estimate Std. Error       df t value Pr(>|t|)    
#> (Intercept)        3.80282    0.23661 67.27186  16.072  < 2e-16 ***
#> TreatmentB        -2.07984    0.30482 46.59177  -6.823 1.58e-08 ***
#> TreatmentC        -0.14938    0.33020 61.66003  -0.452  0.65258    
#> TreatmentD        -1.48185    0.30858 43.88008  -4.802 1.86e-05 ***
#> months             1.95236    0.30779 59.26371   6.343 3.41e-08 ***
#> TreatmentB:months -1.28862    0.39623 41.99207  -3.252  0.00226 ** 
#> TreatmentC:months -0.09432    0.43574 56.60232  -0.216  0.82941    
#> TreatmentD:months -2.48089    0.40349 40.19463  -6.149 2.87e-07 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtmnB TrtmnC TrtmnD months TrtmB: TrtmC:
#> TreatmentB  -0.776                                          
#> TreatmentC  -0.717  0.556                                   
#> TreatmentD  -0.767  0.595  0.549                            
#> months      -0.566  0.439  0.405  0.434                     
#> TrtmntB:mnt  0.439 -0.486 -0.315 -0.337 -0.777              
#> TrtmntC:mnt  0.400 -0.310 -0.557 -0.306 -0.706  0.549       
#> TrtmntD:mnt  0.431 -0.335 -0.309 -0.472 -0.763  0.593  0.539

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
#> Formula: log1p(Volume) ~ Treatment * Week + (Week | ID)
#>    Data: data
#> 
#> REML criterion at convergence: 1425.4
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.55646 -0.38793  0.01298  0.56080  2.09235 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr  
#>  ID       (Intercept) 2.4895   1.5778         
#>           Week        0.3673   0.6061   -1.00 
#>  Residual             3.8081   1.9514         
#> Number of obs: 319, groups:  ID, 28
#> 
#> Fixed effects:
#>                   Estimate Std. Error      df t value Pr(>|t|)    
#> (Intercept)        -2.6356     0.5345 28.9902  -4.931 3.07e-05 ***
#> TreatmentVEH        0.5622     0.7588 29.3956   0.741    0.465    
#> Week                0.8822     0.1686 25.4077   5.233 1.95e-05 ***
#> TreatmentVEH:Week  -0.1595     0.2391 25.6613  -0.667    0.511    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtVEH Week  
#> TreatmntVEH -0.704              
#> Week        -0.908  0.640       
#> TrtmntVEH:W  0.640 -0.909 -0.705
#> optimizer (nloptwrap) convergence code: 0 (OK)
#> boundary (singular) fit: see help('isSingular')
#> 
```
