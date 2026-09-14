# Generalized Addictive Model (GAM)

The package also includes `gam()`, which fits a generalized additive
mixed effects model to tumor growth data. This model is useful when
tumor growth over time follows a complex nonlinear trajectory that
cannot be captured by polynomial terms.

By default, `gam()` fits the model:

\log(1 + \text{measure}) \sim \text{group} + s(\text{time},\\ \text{by}
= \text{group}) + (\text{time} \mid \text{id}) where s(\cdot) is a
group-specific smooth term for time.

## Model fit

``` r

melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
fit <- tumr_gam(mel1)
```

## Result summary

``` r

summary(fit)
```

     contrast   estimate        SE p.value
        A - B  5.5995408 0.7056964  0.0000
        A - C  0.0477361 0.7181460  0.9470
        A - D  7.3182799 0.7286342  0.0000
        B - C -5.5518047 0.7152382  0.0000
        B - D  1.7187391 0.7257685  0.0365
        C - D  7.2705438 0.7378795  0.0000

## Plot

``` r

plot(mel1) 
```

![](gam_files/figure-html/unnamed-chunk-4-1.png)

``` r

plot(mel1) + ggplot2::scale_y_log10()
```

    Warning in ggplot2::scale_y_log10(): log-10 transformation introduced infinite values.
    log-10 transformation introduced infinite values.

![](gam_files/figure-html/unnamed-chunk-4-2.png)

``` r

plot(fit, "predict") + ggplot2::scale_y_log10()
```

![](gam_files/figure-html/unnamed-chunk-4-3.png)

``` r

plot(fit, "contrast")
```

![](gam_files/figure-html/unnamed-chunk-4-4.png)
