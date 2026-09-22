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
#> Warning: optimx: No match to available methods
#> Warning: Default method when bounds specified is L-BFGS-B to match optim()
#> boundary (singular) fit: see help('isSingular')
#> Warning: Model failed to converge with 1 negative eigenvalue: -2.8e+00
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: log(Volume) ~ Treatment * months + (months | ID)
#>    Data: data
#> Control: lme4::lmerControl(optimizer = "optimx", optCtrl = list(method = ""))
#> 
#> REML criterion at convergence: 1737.3
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -2.8201 -0.4436  0.0834  0.4467  3.4895 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr 
#>  ID       (Intercept) 0.0000   0.0000        
#>           months      0.3851   0.6205    NaN 
#>  Residual             0.8840   0.9402        
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>                    Estimate Std. Error        df t value Pr(>|t|)    
#> (Intercept)         3.77929    0.16914 568.46837  22.344  < 2e-16 ***
#> TreatmentB         -1.72949    0.21339 567.18718  -8.105 3.26e-15 ***
#> TreatmentC         -0.15203    0.23489 570.09344  -0.647  0.51774    
#> TreatmentD         -1.24470    0.21525 566.59523  -5.783 1.22e-08 ***
#> months              1.97403    0.25749  57.01186   7.666 2.46e-10 ***
#> TreatmentB:months  -1.29441    0.33576  42.06556  -3.855  0.00039 ***
#> TreatmentC:months  -0.08807    0.36403  55.11280  -0.242  0.80974    
#> TreatmentD:months  -2.30643    0.34266  40.53234  -6.731 4.18e-08 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtmnB TrtmnC TrtmnD months TrtmB: TrtmC:
#> TreatmentB  -0.793                                          
#> TreatmentC  -0.720  0.571                                   
#> TreatmentD  -0.786  0.623  0.566                            
#> months      -0.486  0.385  0.350  0.382                     
#> TrtmntB:mnt  0.372 -0.388 -0.268 -0.293 -0.767              
#> TrtmntC:mnt  0.344 -0.272 -0.476 -0.270 -0.707  0.542       
#> TrtmntD:mnt  0.365 -0.289 -0.263 -0.372 -0.751  0.576  0.532
#> optimizer (optimx) convergence code: 0 (OK)
#> boundary (singular) fit: see help('isSingular')
#> optimx: No match to available methods
#> Default method when bounds specified is L-BFGS-B to match optim()
#> 

lmm(
tumr_obj = mel1,
formula = "Volume ~ Day + (1 | ID)"
)
#> Warning: optimx: No match to available methods
#> Warning: Default method when bounds specified is L-BFGS-B to match optim()
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: Volume ~ Day + (1 | ID)
#>    Data: data
#> Control: lme4::lmerControl(optimizer = "optimx", optCtrl = list(method = ""))
#> 
#> REML criterion at convergence: 8820.6
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -1.5482 -0.5178 -0.1942  0.2721  7.0378 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  ID       (Intercept)  89727   299.5   
#>  Residual             125054   353.6   
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>             Estimate Std. Error       df t value Pr(>|t|)    
#> (Intercept) 127.6467    56.6236  42.6897   2.254   0.0294 *  
#> Day           3.6730     0.4347 584.7749   8.449 2.34e-16 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>     (Intr)
#> Day -0.351
#> optimizer (optimx) convergence code: 0 (OK)
#> optimx: No match to available methods
#> Default method when bounds specified is L-BFGS-B to match optim()
#> 

data(breast)
lmm(
data = breast,
id = "ID",
group = "Treatment",
time = "Week",
measure = "Volume"
)
#> Warning: optimx: No match to available methods
#> Warning: Default method when bounds specified is L-BFGS-B to match optim()
#> boundary (singular) fit: see help('isSingular')
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: log(Volume) ~ Treatment * Week + (Week | ID)
#>    Data: data
#> Control: lme4::lmerControl(optimizer = "optimx", optCtrl = list(method = ""))
#> 
#> REML criterion at convergence: 975.2
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.80082 -0.22807  0.01603  0.60055  2.48668 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr  
#>  ID       (Intercept) 0.8622   0.9285         
#>           Week        0.1148   0.3387   -1.00 
#>  Residual             0.8947   0.9459         
#> Number of obs: 319, groups:  ID, 28
#> 
#> Fixed effects:
#>                   Estimate Std. Error       df t value Pr(>|t|)    
#> (Intercept)        3.31900    0.29485 27.40244  11.257 8.74e-12 ***
#> TreatmentVEH       0.30984    0.41827 27.71346   0.741    0.465    
#> Week               0.44786    0.09333 25.43622   4.798 6.03e-05 ***
#> TreatmentVEH:Week -0.07829    0.13227 25.63737  -0.592    0.559    
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtVEH Week  
#> TreatmntVEH -0.705              
#> Week        -0.932  0.657       
#> TrtmntVEH:W  0.658 -0.932 -0.706
#> optimizer (optimx) convergence code: 0 (OK)
#> boundary (singular) fit: see help('isSingular')
#> optimx: No match to available methods
#> Default method when bounds specified is L-BFGS-B to match optim()
#> 
```
