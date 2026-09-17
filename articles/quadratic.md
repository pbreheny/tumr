# Exponential quadratic Model

The package also includes
[`quad()`](https://pbreheny.github.io/tumr/reference/quad.md), which
fits a Exponential quadratic linear mixed effects model to tumor growth
data. This model is useful when tumor growth over time may be nonlinear
rather than strictly linear.

Exponential quadratic linear mixed models are well suited for
longitudinal tumor growth data because they account for:

- Fixed effects: population-level effects of interest, such as
  treatment, time, and the quadratic effect of time
- Random effects: subject-specific variability that induces correlation
  among repeated measurements

By default,
[`quad()`](https://pbreheny.github.io/tumr/reference/quad.md) fits the
model:

\log(1 + \text{measure}) \sim (\text{time} + \text{time}^2) \*
\text{group} + (\text{time} \mid \text{id})

## Model fit

``` r

melanoma1$months <- melanoma1$Day / (365/12)
mel1 <- tumr(melanoma1, ID, months, Volume, Treatment)
fit_quad <- quad(mel1)
```

## Summary

``` r

summary(fit_quad)
```

    NOTE: Results may be misleading due to involvement in interactions

     contrast   estimate        SE p.value
        A - B  4.6471836 0.5270131  0.0000
        A - C  0.2866918 0.5362210  0.5964
        A - D  5.6587780 0.5425495  0.0000
        B - C -4.3604918 0.5274852  0.0000
        B - D  1.0115944 0.5339173  0.1360
        C - D  5.3720862 0.5430081  0.0000

## Plot

``` r

plot(mel1) 
```

![](quadratic_files/figure-html/unnamed-chunk-4-1.png)

``` r

plot(mel1) + ggplot2::scale_y_log10()
```

    Warning in ggplot2::scale_y_log10(): log-10 transformation introduced infinite values.
    log-10 transformation introduced infinite values.

![](quadratic_files/figure-html/unnamed-chunk-4-2.png)

``` r

plot(fit_quad) + ggplot2::scale_y_log10()
```

![](quadratic_files/figure-html/unnamed-chunk-4-3.png)

``` r

plot(fit_quad, "contrast")
```

![](quadratic_files/figure-html/unnamed-chunk-4-4.png)
