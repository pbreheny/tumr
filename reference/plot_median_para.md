# Plot of tumor growth over time using parametric method

Plot of tumor growth over time using parametric method

## Usage

``` r
plot_median_para(
  tumr_obj = NULL,
  data = NULL,
  group = NULL,
  time = NULL,
  measure = NULL,
  id = NULL
)
```

## Arguments

- tumr_obj:

  takes tumr_obj created by tumr()

- data:

  tumor growth data

- group:

  Column specifying the treatment group

- time:

  Column of repeated time measurements

- measure:

  Column of repeated measurements of tumor

- id:

  Column of subject ID's

## Value

A ggplot object

## Examples

``` r
data(melanoma2)
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
plot_median_para(mel2) + ggplot2::coord_cartesian(ylim = c(0, 2000))
```
