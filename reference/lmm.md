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
#> Formula: log(Volume) ~ Treatment * months + (months | ID)
#>    Data: data
#> Control: 
#> lme4::lmerControl(optimizer = "optimx", optCtrl = list(method = "nlminb"))
#> 
#> REML criterion at convergence: 1735.1
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -2.8282 -0.4655  0.0901  0.4618  3.3950 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr  
#>  ID       (Intercept) 0.05454  0.2335         
#>           months      0.42714  0.6536   -0.40 
#>  Residual             0.86958  0.9325         
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>                   Estimate Std. Error       df t value Pr(>|t|)    
#> (Intercept)        3.78107    0.18511 66.48985  20.426  < 2e-16 ***
#> TreatmentB        -1.72877    0.23894 46.44307  -7.235 3.84e-09 ***
#> TreatmentC        -0.17974    0.25881 61.41199  -0.694 0.490012    
#> TreatmentD        -1.24607    0.24194 43.76732  -5.150 5.93e-06 ***
#> months             1.97101    0.26607 50.71566   7.408 1.28e-09 ***
#> TreatmentB:months -1.29407    0.34919 38.35999  -3.706 0.000663 ***
#> TreatmentC:months -0.05209    0.37730 49.74187  -0.138 0.890742    
#> TreatmentD:months -2.30365    0.35654 37.03446  -6.461 1.49e-07 ***
#> ---
#> Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
#> 
#> Correlation of Fixed Effects:
#>             (Intr) TrtmnB TrtmnC TrtmnD months TrtmB: TrtmC:
#> TreatmentB  -0.775                                          
#> TreatmentC  -0.715  0.554                                   
#> TreatmentD  -0.765  0.593  0.547                            
#> months      -0.564  0.437  0.403  0.431                     
#> TrtmntB:mnt  0.430 -0.494 -0.307 -0.329 -0.762              
#> TrtmntC:mnt  0.398 -0.308 -0.559 -0.304 -0.705  0.537       
#> TrtmntD:mnt  0.421 -0.326 -0.301 -0.483 -0.746  0.569  0.526

lmm(
tumr_obj = mel1,
formula = "Volume ~ Day + (1 | ID)"
)
#> Linear mixed model fit by REML. t-tests use Satterthwaite's method [
#> lmerModLmerTest]
#> Formula: Volume ~ Day + (1 | ID)
#>    Data: data
#> Control: 
#> lme4::lmerControl(optimizer = "optimx", optCtrl = list(method = "nlminb"))
#> 
#> REML criterion at convergence: 8820.6
#> 
#> Scaled residuals: 
#>     Min      1Q  Median      3Q     Max 
#> -1.5482 -0.5178 -0.1942  0.2721  7.0378 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev.
#>  ID       (Intercept)  89726   299.5   
#>  Residual             125054   353.6   
#> Number of obs: 600, groups:  ID, 35
#> 
#> Fixed effects:
#>             Estimate Std. Error       df t value Pr(>|t|)    
#> (Intercept) 127.6468    56.6234  42.6903   2.254   0.0294 *  
#> Day           3.6730     0.4347 584.7749   8.449 2.34e-16 ***
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
#> Formula: log(Volume) ~ Treatment * Week + (Week | ID)
#>    Data: data
#> Control: 
#> lme4::lmerControl(optimizer = "optimx", optCtrl = list(method = "nlminb"))
#> 
#> REML criterion at convergence: 975.2
#> 
#> Scaled residuals: 
#>      Min       1Q   Median       3Q      Max 
#> -2.80081 -0.22807  0.01603  0.60054  2.48668 
#> 
#> Random effects:
#>  Groups   Name        Variance Std.Dev. Corr  
#>  ID       (Intercept) 0.8621   0.9285         
#>           Week        0.1147   0.3387   -1.00 
#>  Residual             0.8947   0.9459         
#> Number of obs: 319, groups:  ID, 28
#> 
#> Fixed effects:
#>                   Estimate Std. Error       df t value Pr(>|t|)    
#> (Intercept)        3.31900    0.29483 27.40569  11.257 8.72e-12 ***
#> TreatmentVEH       0.30984    0.41826 27.71677   0.741    0.465    
#> Week               0.44786    0.09333 25.43923   4.799 6.02e-05 ***
#> TreatmentVEH:Week -0.07829    0.13226 25.64042  -0.592    0.559    
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
#> 
```
