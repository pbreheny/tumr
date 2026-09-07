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

melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
fit_quad <- quad(mel2)
```

## Summary

``` r

summary(fit_quad)
```

    NOTE: Results may be misleading due to involvement in interactions

     contrast   estimate        SE p.value
        A - B  0.6701898 0.3297388  0.2908
        A - C  0.1380658 0.3224121  0.6706
        A - D -0.4240997 0.3299029  0.6152
        A - E  1.0145469 0.3398041  0.0378
        B - C -0.5321240 0.3285497  0.4705
        B - D -1.0942894 0.3359037  0.0194
        B - E  0.3443571 0.3456330  0.6500
        C - D -0.5621654 0.3287145  0.4705
        C - E  0.8764811 0.3386504  0.0929
        D - E  1.4386465 0.3457897  0.0015

## Plot

``` r

plot(fit_quad) + ggplot2::scale_y_log10()
```

    Warning: the 'nobars' function has moved to the reformulas package. Please
    update your imports, or ask an upstream package maintainer to do so.

![](quadratic_files/figure-html/unnamed-chunk-4-1.png)

``` r

plot(fit_quad, "contrast")
```

![](quadratic_files/figure-html/unnamed-chunk-4-2.png)
