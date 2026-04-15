# Plot tumor volume or fold change over time using median curves

Plot tumor volume or fold change over time using median curves

## Usage

``` r
plot_median(
  tumr_obj = NULL,
  data = NULL,
  group = NULL,
  time = NULL,
  measure = NULL,
  id = NULL,
  par = TRUE,
  fold = FALSE
)
```

## Arguments

- tumr_obj:

  Optional tumr object created by tumr()

- data:

  Tumor growth data

- group:

  Column specifying treatment group

- time:

  Column of repeated time measurements

- measure:

  Column of repeated tumor measurements

- id:

  Column of subject IDs

- par:

  Logical. If TRUE, use parametric median estimation. If FALSE, use
  nonparametric Kaplan-Meier estimation.

- fold:

  Logical. If TRUE, plot fold change instead of raw volume.

## Value

A ggplot object

## Examples

``` r
data(melanoma2)
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
plot_median(mel2)

plot_median(mel2, par = FALSE)

plot_median(mel2, fold = TRUE)

plot_median(mel2, par = FALSE, fold = TRUE)

```
