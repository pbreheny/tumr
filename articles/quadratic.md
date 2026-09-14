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
        A - B  5.3935205 0.6351557  0.0000
        A - C  0.2965194 0.6502189  0.6512
        A - D  6.6734450 0.6535717  0.0000
        B - C -5.0970011 0.6358521  0.0000
        B - D  1.2799246 0.6392802  0.1094
        C - D  6.3769256 0.6542485  0.0000

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

    Warning: the 'nobars' function has moved to the reformulas package. Please
    update your imports, or ask an upstream package maintainer to do so.

![](quadratic_files/figure-html/unnamed-chunk-4-3.png)

``` r

plot(fit_quad, "contrast")
```

![](quadratic_files/figure-html/unnamed-chunk-4-4.png)
