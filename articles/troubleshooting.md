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
mel2_day <- tumr(melanoma2, ID, Day, Volume, Treatment)
```

    Warning:
    --------------------------------------------------------------------
    The time range is greater than 50, which may cause convergence
    issues when fitting lmm(). Consider rescaling the time variable
    to a larger unit (e.g., from days to weeks or months).
    --------------------------------------------------------------------

``` r

lmm_day <- lmm(mel2_day)
```

    Loading required namespace: optimx

#### Solution: Rescale the Time Variable

In this case, converting time from days to months resolves the
convergence issue. Below, we create a new time variable by dividing by
the average number of days per month, update the tumr object, and refit
the model:

``` r

melanoma2$months <- melanoma2$Day / (365/12)
mel2_month <- tumr(melanoma2, ID, months, Volume, Treatment)
lmm_month <- lmm(mel2_month)
```

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

lmm_mel2 <- lmm(mel2_month)
plot(lmm_mel2, "response")
```

    Model has log transformed response. Predictions are on transformed
      scale.

![](troubleshooting_files/figure-html/unnamed-chunk-4-1.png)

This approach preserves the model fit while allowing you to visualize
predictions and uncertainty on the transformed scale.

## lmm() Summary with Edited Formula

The lmm() function allows you to override the default model formula,
providing flexibility when fitting alternative model specifications.

By default, lmm() fits a model of the form
`log(measure) ~ group * time + (time | id)` (for example,
`Volume ~ months + (1 | ID)`).

In the example below, the default formula is replaced with a simpler
model that uses a rescaled time variable and a random intercept only:

``` r

lmm_mel2 <- lmm(
                 tumr_obj = mel2_month,
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

``` r

summary(lmm_day)
```

    $`overall effect of time`
     1       Day.trend      SE   df lower.CL upper.CL
     overall    0.0551 0.00403 41.3    0.047   0.0633

    Results are averaged over the levels of: Treatment
    Degrees-of-freedom method: kenward-roger
    Confidence level used: 0.95

    $`slope of treatment over time`
     Treatment Day.trend      SE   df lower.CL upper.CL
     A            0.0771 0.00881 43.3   0.0594   0.0949
     B            0.0403 0.00887 36.5   0.0223   0.0583
     C            0.0534 0.00864 40.6   0.0360   0.0709
     D            0.0554 0.00947 54.0   0.0364   0.0744
     E            0.0493 0.00930 35.1   0.0304   0.0682

    Degrees-of-freedom method: kenward-roger
    Confidence level used: 0.95

    $`test slope differences`
     contrast estimate     SE   df t.ratio p.value
     A - B     0.03683 0.0125 39.6   2.947  0.0403
     A - C     0.02373 0.0123 42.0   1.923  0.3212
     A - D     0.02176 0.0129 48.6   1.683  0.4539
     A - E     0.02785 0.0128 38.7   2.174  0.2109
     B - C    -0.01311 0.0124 38.4  -1.059  0.8261
     B - D    -0.01508 0.0130 44.5  -1.162  0.7724
     B - E    -0.00898 0.0128 35.7  -0.699  0.9554
     C - D    -0.00197 0.0128 47.2  -0.154  0.9999
     C - E     0.00413 0.0127 37.5   0.325  0.9975
     D - E     0.00609 0.0133 43.2   0.459  0.9905

    Degrees-of-freedom method: kenward-roger
    P value adjustment: tukey method for comparing a family of 5 estimates 

``` r

summary(lmm_month)
```

    $`overall effect of time`
     1       months.trend    SE   df lower.CL upper.CL
     overall         1.68 0.123 41.3     1.43     1.92

    Results are averaged over the levels of: Treatment
    Degrees-of-freedom method: kenward-roger
    Confidence level used: 0.95

    $`slope of treatment over time`
     Treatment months.trend    SE   df lower.CL upper.CL
     A                 2.35 0.268 43.3    1.806     2.89
     B                 1.23 0.270 36.5    0.679     1.77
     C                 1.62 0.263 40.6    1.094     2.16
     D                 1.68 0.288 54.0    1.107     2.26
     E                 1.50 0.283 35.1    0.925     2.07

    Degrees-of-freedom method: kenward-roger
    Confidence level used: 0.95

    $`test slope differences`
     contrast estimate    SE   df t.ratio p.value
     A - B      1.1203 0.380 39.6   2.947  0.0403
     A - C      0.7217 0.375 42.0   1.923  0.3212
     A - D      0.6618 0.393 48.6   1.683  0.4539
     A - E      0.8471 0.390 38.7   2.174  0.2109
     B - C     -0.3987 0.376 38.4  -1.059  0.8261
     B - D     -0.4585 0.395 44.5  -1.162  0.7724
     B - E     -0.2732 0.391 35.7  -0.699  0.9554
     C - D     -0.0599 0.390 47.2  -0.154  0.9999
     C - E      0.1255 0.386 37.5   0.325  0.9975
     D - E      0.1854 0.404 43.2   0.459  0.9905

    Degrees-of-freedom method: kenward-roger
    P value adjustment: tukey method for comparing a family of 5 estimates 
