# AR(1)

## AR(1); Day

``` r

mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
```

    Warning:
    --------------------------------------------------------------------
    The time range is greater than 50, which may cause convergence
    issues when fitting lmm(). Consider rescaling the time variable
    to a larger unit (e.g., from days to weeks or months).
    --------------------------------------------------------------------

``` r

limit <- get_limit(mel2)
idx <- !is.na(melanoma2$Volume) & melanoma2$Volume == 0
melanoma2$Volume[idx] <- limit

# Sort by mouse and time
melanoma2 <- melanoma2[order(melanoma2$ID, melanoma2$Day),]

# Fit GLS with AR(1) residual correlation
fit_ar1 <- nlme::gls(
  log(Volume) ~ Treatment * Day,
  data = melanoma2,
  correlation = nlme::corAR1(
    form = ~ Day | ID
  ),
  method = "REML"
)

summary(fit_ar1)
```

    Generalized least squares fit by REML
      Model: log(Volume) ~ Treatment * Day
      Data: melanoma2
           AIC      BIC    logLik
      1704.092 1755.984 -840.0459

    Correlation Structure: ARMA(1,0)
     Formula: ~Day | ID
     Parameter estimate(s):
    Phi1
       0

    Coefficients:
                       Value  Std.Error   t-value p-value
    (Intercept)     4.005396 0.19103917 20.966361  0.0000
    TreatmentB      0.777092 0.24315016  3.195933  0.0015
    TreatmentC      0.654200 0.26491868  2.469437  0.0138
    TreatmentD      1.209237 0.27838939  4.343690  0.0000
    TreatmentE      0.305571 0.25045653  1.220055  0.2230
    Day             0.061253 0.00593140 10.326911  0.0000
    TreatmentB:Day -0.050525 0.00667647 -7.567564  0.0000
    TreatmentC:Day -0.020577 0.00795856 -2.585477  0.0100
    TreatmentD:Day -0.024708 0.00940863 -2.626073  0.0089
    TreatmentE:Day -0.046169 0.00683567 -6.754179  0.0000

     Correlation:
                   (Intr) TrtmnB TrtmnC TrtmnD TrtmnE Day    TrtB:D TrtC:D TrtD:D
    TreatmentB     -0.786
    TreatmentC     -0.721  0.567
    TreatmentD     -0.686  0.539  0.495
    TreatmentE     -0.763  0.599  0.550  0.523
    Day            -0.859  0.675  0.619  0.589  0.655
    TreatmentB:Day  0.763 -0.830 -0.550 -0.524 -0.582 -0.888
    TreatmentC:Day  0.640 -0.503 -0.859 -0.439 -0.488 -0.745  0.662
    TreatmentD:Day  0.541 -0.425 -0.390 -0.845 -0.413 -0.630  0.560  0.470
    TreatmentE:Day  0.745 -0.585 -0.537 -0.511 -0.833 -0.868  0.771  0.647  0.547

    Standardized residuals:
            Min          Q1         Med          Q3         Max
    -4.04761450 -0.61831935  0.08508975  0.64261633  2.14561775

    Residual standard error: 1.01741
    Degrees of freedom: 568 total; 558 residual

## AR(1); Month

``` r

dat <- melanoma2
dat$month <- dat$Day / (365 / 12)
mel2_month <- tumr(dat, ID, month, Volume, Treatment)
limit <- get_limit(mel2_month)
idx <- !is.na(dat$Volume) & dat$Volume == 0
dat$Volume[idx] <- limit
dat <- dat[order(dat$ID, dat$Day),]

fit_ar1_month <- nlme::gls(
  log(Volume) ~ Treatment * month,
  data = dat,
  correlation = nlme::corAR1(
    form = ~ Day | ID
  ),
  method = "REML"
)
summary(fit_ar1_month)
```

    Generalized least squares fit by REML
      Model: log(Volume) ~ Treatment * month
      Data: dat
           AIC      BIC   logLik
      1669.942 1721.834 -822.971

    Correlation Structure: ARMA(1,0)
     Formula: ~Day | ID
     Parameter estimate(s):
    Phi1
       0

    Coefficients:
                         Value Std.Error   t-value p-value
    (Intercept)       4.005396 0.1910392 20.966361  0.0000
    TreatmentB        0.777092 0.2431502  3.195933  0.0015
    TreatmentC        0.654200 0.2649187  2.469437  0.0138
    TreatmentD        1.209237 0.2783894  4.343690  0.0000
    TreatmentE        0.305571 0.2504565  1.220055  0.2230
    month             1.863114 0.1804135 10.326911  0.0000
    TreatmentB:month -1.536791 0.2030760 -7.567564  0.0000
    TreatmentC:month -0.625874 0.2420728 -2.585477  0.0100
    TreatmentD:month -0.751528 0.2861793 -2.626073  0.0089
    TreatmentE:month -1.404317 0.2079183 -6.754179  0.0000

     Correlation:
                     (Intr) TrtmnB TrtmnC TrtmnD TrtmnE month  TrtmB: TrtmC: TrtmD:
    TreatmentB       -0.786
    TreatmentC       -0.721  0.567
    TreatmentD       -0.686  0.539  0.495
    TreatmentE       -0.763  0.599  0.550  0.523
    month            -0.859  0.675  0.619  0.589  0.655
    TreatmentB:month  0.763 -0.830 -0.550 -0.524 -0.582 -0.888
    TreatmentC:month  0.640 -0.503 -0.859 -0.439 -0.488 -0.745  0.662
    TreatmentD:month  0.541 -0.425 -0.390 -0.845 -0.413 -0.630  0.560  0.470
    TreatmentE:month  0.745 -0.585 -0.537 -0.511 -0.833 -0.868  0.771  0.647  0.547

    Standardized residuals:
            Min          Q1         Med          Q3         Max
    -4.04761450 -0.61831935  0.08508975  0.64261633  2.14561775

    Residual standard error: 1.01741
    Degrees of freedom: 568 total; 558 residual

## AR(1) + Mixed effects; Month

``` r

dat <- melanoma2

# Convert Day to month for the mean model
dat$month <- dat$Day / (365 / 12)

# Handle zero volumes in the same way as tumr
mel2_month <- tumr(
  dat,
  ID,
  month,
  Volume,
  Treatment
)

limit <- get_limit(mel2_month)

idx <- !is.na(dat$Volume) & dat$Volume == 0
dat$Volume[idx] <- limit

# Sort by mouse and actual day
dat <- dat[
  order(dat$ID, dat$Day),
]

# Mixed model + AR(1)
fit_mixed_ar1 <- nlme::lme(
  fixed = log(Volume) ~ Treatment * month,
  random = ~ 1 | ID,
  correlation = nlme::corAR1(
    form = ~ Day | ID
  ),
  data = dat,
  method = "REML"
)

summary(fit_mixed_ar1)
```

    Linear mixed-effects model fit by REML
      Data: dat
           AIC      BIC    logLik
      1466.957 1523.174 -720.4787

    Random effects:
     Formula: ~1 | ID
            (Intercept)  Residual
    StdDev:   0.6714438 0.7784818

    Correlation Structure: ARMA(1,0)
     Formula: ~Day | ID
     Parameter estimate(s):
    Phi1
       0
    Fixed effects:  log(Volume) ~ Treatment * month
                         Value Std.Error  DF   t-value p-value
    (Intercept)       3.857558 0.2585690 516 14.918874  0.0000
    TreatmentB        0.759766 0.3613436  42  2.102613  0.0415
    TreatmentC        0.708398 0.3634325  42  1.949189  0.0580
    TreatmentD        1.213143 0.3696996  42  3.281430  0.0021
    TreatmentE        0.228060 0.3728943  42  0.611595  0.5441
    month             2.148362 0.1438275 516 14.937075  0.0000
    TreatmentB:month -1.551632 0.1638189 516 -9.471630  0.0000
    TreatmentC:month -0.748136 0.1927289 516 -3.881803  0.0001
    TreatmentD:month -0.663163 0.2333704 516 -2.841674  0.0047
    TreatmentE:month -1.389892 0.1669758 516 -8.323913  0.0000
     Correlation:
                     (Intr) TrtmnB TrtmnC TrtmnD TrtmnE month  TrtmB: TrtmC: TrtmD:
    TreatmentB       -0.716
    TreatmentC       -0.711  0.509
    TreatmentD       -0.699  0.500  0.498
    TreatmentE       -0.693  0.496  0.493  0.485
    month            -0.487  0.349  0.347  0.341  0.338
    TreatmentB:month  0.428 -0.429 -0.304 -0.299 -0.297 -0.878
    TreatmentC:month  0.364 -0.260 -0.482 -0.254 -0.252 -0.746  0.655
    TreatmentD:month  0.300 -0.215 -0.214 -0.487 -0.208 -0.616  0.541  0.460
    TreatmentE:month  0.420 -0.300 -0.299 -0.293 -0.431 -0.861  0.756  0.643  0.531

    Standardized Within-Group Residuals:
           Min         Q1        Med         Q3        Max
    -4.7217004 -0.3736636  0.1174157  0.5298511  2.8949563

    Number of Observations: 568
    Number of Groups: 47 
