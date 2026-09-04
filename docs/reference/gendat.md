# Generate tumor data: Time to reach endpoint

Generate tumor data: Time to reach endpoint

## Usage

``` r
gendat(n, effect_size = 2, m = 3, alpha = 9, sd = 100)
```

## Arguments

- n:

  Number of mice per group

- effect_size:

  Vector of effect sizes, as a growth ratio (default: 2)

- m:

  Number of measurements per mouse (default: 3)

- alpha:

  Shape parameter for gamma distribution (default: 9)

- sd:

  Noise (standard deviation, default: 100)

## Value

Y Observed measurements

M Idealized 'true' size for each mouse at each time (no error)

B 'True' growth rate for each mouse (in data-generating mechanism)

## Examples

``` r
Data <- gendat(5, effect_size=2, m=6)
matplot(Data$time, t(Data$Y[,,1]), lty=1, type='l', col='#FF4E37', bty='n', las=1,
        ylab=expression("Tumor volume "*(mm^3)), xlab='Day')
matplot(Data$time, t(Data$Y[,,2]), lty=1, type='l', col='#008DFF', add=TRUE)

```
