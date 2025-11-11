# Getting started with the tumr package

We should write a brief intro here for one of the data sets.

## melanoma2 data set

``` r
library(tumr)
data("melanoma2")
```

#### Code for plot_mean()

Code

``` r
plot_mean <- function(data, group, time, measure, id, stat = median, remove_na = FALSE){
  data_summary <- data |>
    dplyr::group_by({{group}}, {{time}}) |>
    dplyr::summarise(measure = stat({{measure}}, na.rm = remove_na), .groups = "drop_last") |>
    dplyr::ungroup()

  if (remove_na == TRUE){
    data_full <- data |>
      na.omit(data)
  } else {
    data_full <- data
  }

  ggplot2::ggplot() +
    ggplot2::geom_line(data = data_full,
                       ggplot2::aes(x = {{time}},
                                    y = {{measure}},
                                    group = {{id}},
                                    color = {{group}}),
                       alpha = 0.5)  +
    ggplot2::geom_line(data = data_summary,
                       ggplot2::aes(x = {{time}},
                                    y = measure,
                                    color = {{group}}),
                       linewidth = 1.2)

}
```

## Plotting the Mean vs the Median

``` r
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
plot_mean(melanoma2, Treatment, Day, Volume, ID, stat = mean)
mel2 |>
  plot_median()
```

![](tumr_files/figure-html/unnamed-chunk-3-1.png)

![](tumr_files/figure-html/unnamed-chunk-3-2.png)

## Response Feature Analysis of melanoma2

``` r
(rfeat_mel2 <- mel2 |>
              rfeat(comparison = "both"))
```

    $anova
                Df Sum Sq Mean Sq F value Pr(>F)
    Group        4   1803   450.7   3.408 0.0168 *
    Residuals   42   5554   132.2
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    $tukey
      Tukey multiple comparisons of means
        95% family-wise confidence level

    Fit: aov(formula = Beta ~ Group, data = betas)

    $Group
               diff         lwr        upr     p adj
    B-A -12.9067597 -27.9647734  2.1512540 0.1239895
    C-A  -5.8980893 -20.5544836  8.7583050 0.7807978
    D-A   1.4573384 -13.1990559 16.1137327 0.9985310
    E-A -13.5892260 -29.1346797  1.9562277 0.1120331
    C-B   7.0086704  -8.0493433 22.0666841 0.6765864
    D-B  14.3640981  -0.6939156 29.4221119 0.0679418
    E-B  -0.6824663 -16.6071331 15.2422006 0.9999476
    D-C   7.3554277  -7.3009666 22.0118221 0.6121467
    E-C  -7.6911367 -23.2365904  7.8543170 0.6248441
    E-D -15.0465644 -30.5920181  0.4988893 0.0619834

## rfeat plot

``` r
plot(rfeat_mel2)
```

![](tumr_files/figure-html/unnamed-chunk-5-1.png)

## Linear mixed model

``` r
(lmm_mel2 <- mel2 |>
  lmm())
```

    Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    Model failed to converge with max|grad| = 0.00566844 (tol = 0.002, component 1)

    Linear mixed model fit by REML. t-tests use Satterthwaite's method [
    lmerModLmerTest]
    Formula: log1p(Volume) ~ Treatment * Day + (Day | ID)
       Data: data

    REML criterion at convergence: 1216.5

    Scaled residuals:
        Min      1Q  Median      3Q     Max
    -6.8683 -0.3590  0.0569  0.4891  4.0759

    Random effects:
     Groups   Name        Variance  Std.Dev. Corr
     ID       (Intercept) 0.3909753 0.62528
              Day         0.0006511 0.02552  -0.51
     Residual             0.3220706 0.56751
    Number of obs: 568, groups:  ID, 47

    Fixed effects:
                   Estimate Std. Error       df t value Pr(>|t|)
    (Intercept)     3.66092    0.22688 46.83127  16.136  < 2e-16 ***
    TreatmentB      0.53834    0.32255 42.89746   1.669  0.10240
    TreatmentC      0.78053    0.31957 46.08359   2.442  0.01848 *
    TreatmentD      1.33290    0.32410 48.71755   4.113  0.00015 ***
    TreatmentE     -0.14693    0.33197 42.42209  -0.443  0.66031
    Day             0.07971    0.00897 47.89633   8.886 1.06e-11 ***
    TreatmentB:Day -0.03972    0.01269 43.36203  -3.130  0.00312 **
    TreatmentC:Day -0.02673    0.01255 46.24553  -2.129  0.03859 *
    TreatmentD:Day -0.02497    0.01321 54.20921  -1.890  0.06410 .
    TreatmentE:Day -0.03060    0.01300 42.19464  -2.355  0.02325 *
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
                (Intr) TrtmnB TrtmnC TrtmnD TrtmnE Day    TrtB:D TrtC:D TrtD:D
    TreatmentB  -0.703
    TreatmentC  -0.710  0.499
    TreatmentD  -0.700  0.492  0.497
    TreatmentE  -0.683  0.481  0.485  0.478
    Day         -0.577  0.406  0.410  0.404  0.394
    TretmntB:Dy  0.408 -0.560 -0.290 -0.286 -0.279 -0.707
    TretmntC:Dy  0.412 -0.290 -0.573 -0.289 -0.282 -0.715  0.505
    TretmntD:Dy  0.392 -0.276 -0.278 -0.585 -0.268 -0.679  0.480  0.485
    TretmntE:Dy  0.398 -0.280 -0.283 -0.279 -0.556 -0.690  0.488  0.493  0.469
    optimizer (nloptwrap) convergence code: 0 (OK)
    Model failed to converge with max|grad| = 0.00566844 (tol = 0.002, component 1)

## summary of mixed model

``` r
(emm_sum <- summary(lmm_mel2))
```

    Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed
    Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed

    $`overall effect of time`
     1       Day.trend     SE   df lower.CL upper.CL
     overall    0.0553 0.0041 45.4    0.047   0.0636

    Results are averaged over the levels of: Treatment
    Degrees-of-freedom method: satterthwaite
    Confidence level used: 0.95

    $`slope of treatment over time`
     Treatment Day.trend      SE   df lower.CL upper.CL
     A            0.0797 0.00897 47.9   0.0617   0.0977
     B            0.0400 0.00898 39.4   0.0218   0.0581
     C            0.0530 0.00878 44.6   0.0353   0.0707
     D            0.0547 0.00970 60.6   0.0354   0.0741
     E            0.0491 0.00940 37.8   0.0301   0.0681

    Degrees-of-freedom method: satterthwaite
    Confidence level used: 0.95

    $`test slope differences`
     contrast estimate     SE   df t.ratio p.value
     A - B     0.03972 0.0127 43.4   3.130  0.0246
     A - C     0.02673 0.0126 46.2   2.129  0.2254
     A - D     0.02497 0.0132 54.2   1.890  0.3349
     A - E     0.03060 0.0130 42.2   2.355  0.1481
     B - C    -0.01300 0.0126 41.9  -1.035  0.8377
     B - D    -0.01476 0.0132 49.2  -1.117  0.7968
     B - E    -0.00912 0.0130 38.6  -0.702  0.9549
     C - D    -0.00176 0.0131 52.5  -0.135  0.9999
     C - E     0.00388 0.0129 40.8   0.301  0.9981
     D - E     0.00564 0.0135 47.6   0.417  0.9934

    Degrees-of-freedom method: satterthwaite
    P value adjustment: tukey method for comparing a family of 5 estimates 

## Looking at different data sets

``` r
breast_meta <- tumr(breast, ID, Week, Volume, Treatment)

plot_median(breast_meta)
```

![](tumr_files/figure-html/unnamed-chunk-8-1.png)

``` r
breast_rfeat <- rfeat(breast_meta, comparison = "t.test")
plot(breast_rfeat)
```

![](tumr_files/figure-html/unnamed-chunk-8-2.png)

``` r
breast_lmm <- lmm(breast_meta)
```

    boundary (singular) fit: see help('isSingular')

``` r
summary(breast_lmm)
```

    Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed

    Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed

    $`overall effect of time`
     1       Week.trend   SE   df lower.CL upper.CL
     overall      0.802 0.12 25.7    0.557     1.05

    Results are averaged over the levels of: Treatment
    Degrees-of-freedom method: satterthwaite
    Confidence level used: 0.95

    $`slope of treatment over time`
     Treatment Week.trend    SE   df lower.CL upper.CL
     NR             0.882 0.169 25.4    0.535     1.23
     VEH            0.723 0.169 25.9    0.374     1.07

    Degrees-of-freedom method: satterthwaite
    Confidence level used: 0.95

    $`test slope differences`
     contrast estimate    SE   df t.ratio p.value
     NR - VEH     0.16 0.239 25.7   0.667  0.5106

    Degrees-of-freedom method: satterthwaite 

``` r
mel1_meta <- tumr(melanoma1, ID, Day, Volume, Treatment)

plot_median(mel1_meta)
```

![](tumr_files/figure-html/unnamed-chunk-9-1.png)

``` r
(mel1_rfeat <- rfeat(mel1_meta, comparison = "both"))
```

    $anova
                Df Sum Sq Mean Sq F value   Pr(>F)
    Group        3   4645  1548.3   35.62 3.64e-10 ***
    Residuals   31   1347    43.5
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    $tukey
      Tukey multiple comparisons of means
        95% family-wise confidence level

    Fit: aov(formula = Beta ~ Group, data = betas)

    $Group
              diff        lwr        upr     p adj
    B-A -22.058493 -30.493598 -13.623388 0.0000003
    C-A  -4.427555 -12.862660   4.007550 0.4940635
    D-A -27.682834 -36.377542 -18.988126 0.0000000
    C-B  17.630938   9.195833  26.066043 0.0000179
    D-B  -5.624341 -14.319048   3.070367 0.3134169
    D-C -23.255279 -31.949987 -14.560571 0.0000002

``` r
plot(mel1_rfeat)
```

![](tumr_files/figure-html/unnamed-chunk-9-2.png)

``` r
#(mel1_lmm <- lmm(mel1_meta, log1p(Volume) ~ Treatment*Day + (Day | ID)))
#summary(mel1_lmm)
```

``` r
pros_meta <- tumr(prostate, ID, Age, BLI, Genotype)

plot_median(pros_meta)
```

![](tumr_files/figure-html/unnamed-chunk-10-1.png)

``` r
(pros_rfeat <- rfeat(pros_meta, comparison = "both"))
```

    $anova
                Df    Sum Sq   Mean Sq F value   Pr(>F)
    Group        2 6.588e+18 3.294e+18   13.71 2.14e-05 ***
    Residuals   46 1.105e+19 2.403e+17
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    $tukey
      Tukey multiple comparisons of means
        95% family-wise confidence level

    Fit: aov(formula = Beta ~ Group, data = betas)

    $Group
                   diff         lwr        upr     p adj
    HET-DOKO -656394790 -1063611872 -249177709 0.0008827
    WT-DOKO  -858422884 -1278994877 -437850891 0.0000313
    WT-HET   -202028094  -622600087  218543899 0.4808144

``` r
plot(pros_rfeat)
```

![](tumr_files/figure-html/unnamed-chunk-10-2.png)

``` r
(pros_lmm <- lmm(pros_meta))
```

    Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, :
    Model failed to converge with max|grad| = 0.00478111 (tol = 0.002, component 1)

    Linear mixed model fit by REML. t-tests use Satterthwaite's method [
    lmerModLmerTest]
    Formula: log1p(BLI) ~ Genotype * Age + (Age | ID)
       Data: data

    REML criterion at convergence: 1423.8

    Scaled residuals:
        Min      1Q  Median      3Q     Max
    -5.2046 -0.4834  0.0116  0.5532  3.2088

    Random effects:
     Groups   Name        Variance  Std.Dev. Corr
     ID       (Intercept) 0.1824792 0.42718
              Age         0.0006397 0.02529  -0.91
     Residual             0.4264456 0.65303
    Number of obs: 662, groups:  ID, 49

    Fixed effects:
                     Estimate Std. Error        df t value Pr(>|t|)
    (Intercept)     18.849994   0.159658 73.273902 118.065  < 2e-16 ***
    GenotypeHET      1.161121   0.215336 58.907212   5.392 1.29e-06 ***
    GenotypeWT       1.203959   0.217579 53.964181   5.533 9.45e-07 ***
    Age              0.172293   0.009613 95.312319  17.923  < 2e-16 ***
    GenotypeHET:Age -0.107699   0.012541 63.665873  -8.588 3.10e-12 ***
    GenotypeWT:Age  -0.125381   0.012553 57.175131  -9.988 3.79e-14 ***
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
                (Intr) GntHET GntyWT Age    GHET:A
    GenotypeHET -0.741
    GenotypeWT  -0.734  0.544
    Age         -0.911  0.675  0.668
    GntypHET:Ag  0.698 -0.903 -0.512 -0.767
    GentypWT:Ag  0.697 -0.517 -0.901 -0.766  0.587
    optimizer (nloptwrap) convergence code: 0 (OK)
    Model failed to converge with max|grad| = 0.00478111 (tol = 0.002, component 1)

``` r
summary(pros_lmm)
```

    Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed
    Cannot use mode = "kenward-roger" because *pbkrtest* package is not installed

    $`overall effect of time`
     1       Age.trend      SE   df lower.CL upper.CL
     overall    0.0946 0.00497 51.1   0.0846    0.105

    Results are averaged over the levels of: Genotype
    Degrees-of-freedom method: satterthwaite
    Confidence level used: 0.95

    $`slope of treatment over time`
     Genotype Age.trend      SE   df lower.CL upper.CL
     DOKO        0.1723 0.00961 95.3   0.1532   0.1914
     HET         0.0646 0.00805 39.6   0.0483   0.0809
     WT          0.0469 0.00807 32.4   0.0305   0.0633

    Degrees-of-freedom method: satterthwaite
    Confidence level used: 0.95

    $`test slope differences`
     contrast   estimate     SE   df t.ratio p.value
     DOKO - HET   0.1077 0.0125 63.7   8.588  <.0001
     DOKO - WT    0.1254 0.0126 57.2   9.988  <.0001
     HET - WT     0.0177 0.0114 35.7   1.551  0.2800

    Degrees-of-freedom method: satterthwaite
    P value adjustment: tukey method for comparing a family of 3 estimates 
