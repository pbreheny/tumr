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

plot(mel1, par = TRUE, fold = FALSE, panel = TRUE)
```

![](data_files/figure-html/unnamed-chunk-4-1.png)

``` r

plot(mel1, par = TRUE, fold = TRUE, panel = TRUE)
```

![](data_files/figure-html/unnamed-chunk-4-2.png)

``` r

plot(mel1, par = TRUE, fold = FALSE) + ggplot2::scale_y_log10()
plot(mel1, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-5-1.png)

![](data_files/figure-html/unnamed-chunk-5-2.png)

``` r

plot(mel1, par = TRUE, fold = FALSE, panel = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-6-1.png)

``` r

plot(mel1, par = TRUE, fold = TRUE, panel = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-6-2.png)

## Breast Cancer Data Set, *breast*

``` r

plot(breast_meta, par = TRUE, fold = FALSE)
plot(breast_meta, par = TRUE, fold = TRUE)
```

![](data_files/figure-html/unnamed-chunk-8-1.png)

![](data_files/figure-html/unnamed-chunk-8-2.png)

``` r

plot(breast_meta, par = TRUE, fold = FALSE, panel = TRUE)
```

![](data_files/figure-html/unnamed-chunk-9-1.png)

``` r

plot(breast_meta, par = TRUE, fold = TRUE, panel = TRUE)
```

![](data_files/figure-html/unnamed-chunk-9-2.png)

``` r

plot(breast_meta, par = TRUE, fold = FALSE) + ggplot2::scale_y_log10()
plot(breast_meta, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-10-1.png)

![](data_files/figure-html/unnamed-chunk-10-2.png)

``` r

plot(breast_meta, par = TRUE, fold = FALSE, panel = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-11-1.png)

``` r

plot(breast_meta, par = TRUE, fold = TRUE, panel = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-11-2.png)

## Prostate Cancer Data Set, *prostate*

``` r

plot(pros_meta, par = TRUE, fold = FALSE)
plot(pros_meta, par = TRUE, fold = TRUE)
```

![](data_files/figure-html/unnamed-chunk-13-1.png)

![](data_files/figure-html/unnamed-chunk-13-2.png)

``` r

plot(pros_meta, par = TRUE, fold = FALSE, panel = TRUE)
```

![](data_files/figure-html/unnamed-chunk-14-1.png)

``` r

plot(pros_meta, par = TRUE, fold = TRUE, panel = TRUE)
```

![](data_files/figure-html/unnamed-chunk-14-2.png)

``` r

plot(pros_meta, par = TRUE, fold = FALSE) + ggplot2::scale_y_log10()
plot(pros_meta, par = TRUE, fold = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-15-1.png)

![](data_files/figure-html/unnamed-chunk-15-2.png)

``` r

plot(pros_meta, par = TRUE, fold = FALSE, panel = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-16-1.png)

``` r

plot(pros_meta, par = TRUE, fold = TRUE, panel = TRUE) + ggplot2::scale_y_log10()
```

![](data_files/figure-html/unnamed-chunk-16-2.png)
