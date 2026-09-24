# tumr data sets

## Introduction

Each dataset is presented with four plots:

- Parametric method (original scale)
- Parametric method (original scale; fold change)
- Parametric method (log scale)
- Parametric method (log scale; fold change)

## Another Melanoma Data Set, *melanoma1*

``` r

plot(mel1, par = TRUE, fold = FALSE)
plot(mel1, par = TRUE, fold = TRUE)
```

![](data_files/figure-html/unnamed-chunk-3-1.png)

![](data_files/figure-html/unnamed-chunk-3-2.png)

``` r

plot(mel1, par = TRUE, fold = FALSE) + ggplot2::scale_y_log10()
```

    Warning in ggplot2::scale_y_log10(): log-10 transformation introduced infinite values.
    log-10 transformation introduced infinite values.

``` r

plot(mel1, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-4-1.png)

![](data_files/figure-html/unnamed-chunk-4-2.png)

## Breast Cancer Data Set, *breast*

``` r

plot(breast_meta, par = TRUE, fold = FALSE)
plot(breast_meta, par = TRUE, fold = TRUE)
```

![](data_files/figure-html/unnamed-chunk-6-1.png)

![](data_files/figure-html/unnamed-chunk-6-2.png)

``` r

plot(breast_meta, par = TRUE, fold = FALSE) + ggplot2::scale_y_log10()
```

    Warning in ggplot2::scale_y_log10(): log-10 transformation introduced infinite values.
    log-10 transformation introduced infinite values.

``` r

plot(breast_meta, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-7-1.png)

![](data_files/figure-html/unnamed-chunk-7-2.png)

## Prostate Cancer Data Set, *prostate*

``` r

plot(pros_meta, par = TRUE, fold = FALSE)
plot(pros_meta, par = TRUE, fold = TRUE)
```

![](data_files/figure-html/unnamed-chunk-9-1.png)

![](data_files/figure-html/unnamed-chunk-9-2.png)

``` r

plot(pros_meta, par = TRUE, fold = FALSE) + ggplot2::scale_y_log10()
plot(pros_meta, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-10-1.png)

![](data_files/figure-html/unnamed-chunk-10-2.png)
