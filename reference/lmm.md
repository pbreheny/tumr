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
#> Warning: Model failed to converge with max|grad| = 0.3043 (tol = 0.002, component 1)
#>   See ?lme4::convergence and ?lme4::troubleshooting.
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: log1p(Volume) ~ Treatment * Day + (Day | ID)
#>    Data: data
#> 
#> REML criterion at convergence: 2057.9
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -2.7388 -0.4455  0.0897  0.5194  3.2523 
#> 
#> Random effects:
#>  Groups   Name        Variance  Std.Dev. Corr 
#>  ID       (Intercept) 0.1006944 0.31732       
#>           Day         0.0005492 0.02344  -0.29
#>  Residual             1.4496878 1.20403       
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>                 Estimate Std. Error        df t value Pr(>|t|)    
#> (Intercept)     3.803278   0.241055 63.696770  15.778  < 2e-16 ***
#> TreatmentB     -2.077289   0.311809 44.850653  -6.662 3.29e-08 ***
#> TreatmentC     -0.151380   0.336695 58.812300  -0.450  0.65465    
#> TreatmentD     -1.482092   0.315893 42.320462  -4.692 2.84e-05 ***
#> Day             0.064163   0.010131 58.005388   6.333 3.82e-08 ***
#> TreatmentB:Day -0.042430   0.013049 41.175964  -3.252  0.00229 ** 
#> TreatmentC:Day -0.003019   0.014348 55.455508  -0.210  0.83412    
#> TreatmentD:Day -0.081544   0.013289 39.417584  -6.136 3.21e-07 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtmnB TrtmnC TrtmnD Day    TrtB:D TrtC:D
#> TreatmentB  -0.773                                          
#> TreatmentC  -0.716  0.553                                   
#> TreatmentD  -0.763  0.590  0.546                            
#> Day         -0.567  0.438  0.406  0.432                     
#> TretmntB:Dy  0.440 -0.489 -0.315 -0.336 -0.776              
#> TretmntC:Dy  0.400 -0.309 -0.559 -0.305 -0.706  0.548       
#> TretmntD:Dy  0.432 -0.334 -0.309 -0.475 -0.762  0.592  0.538
#> optimizer (nloptwrap) convergence code: 0 (OK)
#> Model failed to converge with max|grad| = 0.3043 (tol = 0.002, component 1)
#>   See ?lme4::convergence and ?lme4::troubleshooting.
#> 

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
