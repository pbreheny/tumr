# tumr data sets

``` r
library(tumr)
```

## Another Melanoma Data Set, *melanoma1*

``` r
data(melanoma1)
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)

plot_median(mel1)
```

![](data_files/figure-html/unnamed-chunk-2-1.png)

## Breast Cancer Data Set, *breast*

``` r
data(breast)
breast_meta <- tumr(breast, ID, Week, Volume, Treatment)

plot_median(breast_meta)
```

![](data_files/figure-html/unnamed-chunk-3-1.png)

## Prostate Cancer Data Set, *prostate*

``` r
data(prostate)
pros_meta <- tumr(prostate, ID, Age, BLI, Genotype)

plot_median(pros_meta)
```

![](data_files/figure-html/unnamed-chunk-4-1.png)
