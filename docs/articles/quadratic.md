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
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
```

    Warning:
    --------------------------------------------------------------------
    The time range is greater than 50, which may cause convergence
    issues when fitting lmm(). Consider rescaling the time variable
    to a larger unit (e.g., from days to weeks or months).
    --------------------------------------------------------------------

``` r
fit_quad <- quad(mel2)
```

    Warning: Some predictor variables are on very different scales: consider
    rescaling

## Summary

``` r
summary(fit_quad)
```

    NOTE: Results may be misleading due to involvement in interactions

     contrast   estimate        SE p.value
        A - B  0.6701901 0.3297438  0.2909
        A - C  0.1380662 0.3224170  0.6706
        A - D -0.4241015 0.3299077  0.6152
        A - E  1.0145473 0.3398094  0.0378
        B - C -0.5321239 0.3285548  0.4705
        B - D -1.0942917 0.3359087  0.0194
        B - E  0.3443572 0.3456385  0.6500
        C - D -0.5621677 0.3287193  0.4705
        C - E  0.8764811 0.3386557  0.0929
        D - E  1.4386489 0.3457948  0.0015

## Plot

``` r
plot(fit_quad) + ggplot2::scale_y_log10()
```

![](quadratic_files/figure-html/unnamed-chunk-4-1.png)

``` r
plot(fit_quad, "contrast")
```

![](quadratic_files/figure-html/unnamed-chunk-4-2.png)
