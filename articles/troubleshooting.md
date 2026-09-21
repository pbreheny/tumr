# Troubleshooting

## Convergence Failure with lmm()

If you encounter the warning

*“Model failed to converge with max\|grad\|”*

when fitting a model with lmm(), one common cause is poor scaling of the
time variable. A simple and effective fix is to rescale time to a larger
unit (for example, from days to months).

#### Example

Using the melanoma2 dataset, the following code produces a convergence
warning:

``` r

data(melanoma2)
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
```

    Warning:
    --------------------------------------------------------------------
    The time range is greater than 50, which may cause convergence
    issues when fitting lmm(). Consider rescaling the time variable
    to a larger unit (e.g., from days to weeks or months).
    --------------------------------------------------------------------

``` r

lmm(mel2)
```

    Warning in checkConv(attr(opt, "derivs"), opt$par, ctrl = control$checkConv, : Model failed to converge with max|grad| = 0.00344115 (tol = 0.002, component 1)
      See ?lme4::convergence and ?lme4::troubleshooting.

    Linear mixed model fit by REML. t-tests use Satterthwaite's method [
    lmerModLmerTest]
    Formula: log(Volume) ~ Treatment * Day + (Day | ID)
       Data: data

    REML criterion at convergence: 1128.3

    Scaled residuals:
        Min      1Q  Median      3Q     Max
    -5.5492 -0.3928  0.0561  0.5222  3.9679

    Random effects:
     Groups   Name        Variance  Std.Dev. Corr
     ID       (Intercept) 0.3419799 0.58479
              Day         0.0006442 0.02538  -0.49
     Residual             0.2708830 0.52046
    Number of obs: 568, groups:  ID, 47

    Fixed effects:
                    Estimate Std. Error        df t value Pr(>|t|)
    (Intercept)     3.759346   0.211256 46.949189  17.795  < 2e-16 ***
    TreatmentB      0.434492   0.300530 43.122979   1.446 0.155476
    TreatmentC      0.667379   0.297585 46.216638   2.243 0.029757 *
    TreatmentD      1.222233   0.301738 48.811194   4.051 0.000182 ***
    TreatmentE     -0.253850   0.309317 42.649535  -0.821 0.416392
    Day             0.077142   0.008801 47.288568   8.765 1.79e-11 ***
    TreatmentB:Day -0.036832   0.012490 43.314950  -2.949 0.005122 **
    TreatmentC:Day -0.023726   0.012329 45.807834  -1.924 0.060535 .
    TreatmentD:Day -0.021757   0.012912 52.974114  -1.685 0.097872 .
    TreatmentE:Day -0.027851   0.012803 42.261692  -2.175 0.035250 *
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
                (Intr) TrtmnB TrtmnC TrtmnD TrtmnE Day    TrtB:D TrtC:D TrtD:D
    TreatmentB  -0.703
    TreatmentC  -0.710  0.499
    TreatmentD  -0.700  0.492  0.497
    TreatmentE  -0.683  0.480  0.485  0.478
    Day         -0.556  0.391  0.395  0.390  0.380
    TretmntB:Dy  0.392 -0.539 -0.278 -0.275 -0.268 -0.705
    TretmntC:Dy  0.397 -0.279 -0.552 -0.278 -0.271 -0.714  0.503
    TretmntD:Dy  0.379 -0.267 -0.269 -0.566 -0.259 -0.682  0.480  0.487
    TretmntE:Dy  0.383 -0.269 -0.272 -0.268 -0.536 -0.687  0.484  0.491  0.469
    optimizer (nloptwrap) convergence code: 0 (OK)
    Model failed to converge with max|grad| = 0.00344115 (tol = 0.002, component 1)
      See ?lme4::convergence and ?lme4::troubleshooting.

#### Solution: Rescale the Time Variable

In this case, converting time from days to months resolves the
convergence issue. Below, we create a new time variable by dividing by
the average number of days per month, update the tumr object, and refit
the model:

``` r

melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
lmm(mel2)
```

    Linear mixed model fit by REML. t-tests use Satterthwaite's method [
    lmerModLmerTest]
    Formula: log(Volume) ~ Treatment * months + (months | ID)
       Data: data

    REML criterion at convergence: 1094.2

    Scaled residuals:
        Min      1Q  Median      3Q     Max
    -5.5492 -0.3928  0.0561  0.5222  3.9679

    Random effects:
     Groups   Name        Variance Std.Dev. Corr
     ID       (Intercept) 0.3420   0.5848
              months      0.5959   0.7720   -0.49
     Residual             0.2709   0.5205
    Number of obs: 568, groups:  ID, 47

    Fixed effects:
                      Estimate Std. Error      df t value Pr(>|t|)
    (Intercept)         3.7593     0.2113 46.9473  17.795  < 2e-16 ***
    TreatmentB          0.4345     0.3005 43.1214   1.446 0.155481
    TreatmentC          0.6674     0.2976 46.2148   2.243 0.029760 *
    TreatmentD          1.2222     0.3017 48.8092   4.051 0.000182 ***
    TreatmentE         -0.2539     0.3093 42.6480  -0.821 0.416399
    months              2.3464     0.2677 47.2957   8.766 1.78e-11 ***
    TreatmentB:months  -1.1203     0.3799 43.3211  -2.949 0.005119 **
    TreatmentC:months  -0.7217     0.3750 45.8146  -1.924 0.060522 .
    TreatmentD:months  -0.6618     0.3927 52.9825  -1.685 0.097854 .
    TreatmentE:months  -0.8471     0.3894 42.2676  -2.175 0.035241 *
    ---
    Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    Correlation of Fixed Effects:
                (Intr) TrtmnB TrtmnC TrtmnD TrtmnE months TrtmB: TrtmC: TrtmD:
    TreatmentB  -0.703
    TreatmentC  -0.710  0.499
    TreatmentD  -0.700  0.492  0.497
    TreatmentE  -0.683  0.480  0.485  0.478
    months      -0.556  0.391  0.395  0.390  0.380
    TrtmntB:mnt  0.392 -0.539 -0.278 -0.275 -0.268 -0.705
    TrtmntC:mnt  0.397 -0.279 -0.552 -0.278 -0.271 -0.714  0.503
    TrtmntD:mnt  0.379 -0.267 -0.269 -0.566 -0.259 -0.682  0.480  0.487
    TrtmntE:mnt  0.383 -0.269 -0.272 -0.268 -0.536 -0.687  0.484  0.491  0.469

After rescaling the time variable, the model fits without producing the
convergence warning.

#### Why This Works

Rescaling time can improve numerical stability during optimization,
making it easier for the model to converge—especially when time values
are large or measured on a very fine scale.

## Putting lmm() Summary Plot on the Log Scale

When viewing the summary plot from lmm(), you may see the message:

*“Model has log1p-transformed response. Back-transforming predictions to
original response scale.Standard errors are still on the transformed
scale.”*

This message appears because lmm() fits the model using a
log1p-transformed response by default, and the plot() method
automatically back-transforms predicted values to the original response
scale.

If you prefer to view the predicted volume values on the log scale, you
can apply a log transformation directly to the plot’s y-axis. Since the
summary plot is a ggplot2 object, this can be done using
scale_y_continuous() with a log1p transformation from the scales
package.

``` r

lmm_mel2 <- lmm(mel2)
plot(lmm_mel2, "response") + ggplot2::scale_y_continuous(trans = scales::log1p_trans())
```

    Model has log transformed response. Predictions are on transformed
      scale.

    Scale for y is already present.
    Adding another scale for y, which will replace the existing scale.

![](troubleshooting_files/figure-html/unnamed-chunk-4-1.png)

This approach preserves the model fit while allowing you to visualize
predictions and uncertainty on the transformed scale.

## lmm() Summary with Edited Formula

The lmm() function allows you to override the default model formula,
providing flexibility when fitting alternative model specifications.

By default, lmm() fits a model of the form
`log1p(measure) ~ group * time + (time | id)` (for example,
`Volume ~ months + (1 | ID)`).

In the example below, the default formula is replaced with a simpler
model that uses a rescaled time variable and a random intercept only:

``` r

lmm_mel2 <- lmm(
                 tumr_obj = mel2,
                 formula = "Volume ~ months + (1 | ID)"
               )
```

While the model fits successfully, calling summary() on this object will
fail.

This occurs because the summary() method is designed around the default
lmm() model structure and currently assumes that formula. As a result,
alternative formulas may not be fully supported by summary().

When using a custom formula, keep in mind that some downstream
methods—such as summary()—may not behave as expected.
