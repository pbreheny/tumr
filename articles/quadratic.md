# Quadratic Linear Mixed Model

The package also includes
[`quad()`](https://pbreheny.github.io/tumr/reference/quad.md), which
fits a quadratic linear mixed effects model to tumor growth data. This
model is useful when tumor growth over time may be nonlinear rather than
strictly linear.

Quadratic linear mixed models are well suited for longitudinal tumor
growth data because they account for:

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

mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
fit_quad <- quad(mel2)
```

## Summary

``` r

summary(fit_quad)
```

    NOTE: Results may be misleading due to involvement in interactions

     contrast   estimate        SE p.value
        A - B  0.6701899 0.3297400  0.2908
        A - C  0.1380658 0.3224133  0.6706
        A - D -0.4241003 0.3299041  0.6152
        A - E  1.0145467 0.3398054  0.0378
        B - C -0.5321241 0.3285510  0.4705
        B - D -1.0942902 0.3359049  0.0194
        B - E  0.3443568 0.3456344  0.6500
        C - D -0.5621661 0.3287156  0.4705
        C - E  0.8764809 0.3386517  0.0929
        D - E  1.4386470 0.3457909  0.0015

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
