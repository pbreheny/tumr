# Plot of tumor growth over time using the median

Plot of tumor growth over time using the median

## Usage

``` r
plot_median(
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

  Column specifying the treatment group for each measurement

- time:

  Column of repeated time measurements

- measure:

  Column of repeated measurements of tumor

- id:

  Column of subject ID's

## Value

A plot

## Examples

``` r
data(melanoma1)
mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
plot_median(
tumr_obj = mel1
)

data(melanoma2)
plot_median(
data = melanoma2,
group = "Treatment",
time = "Day",
measure = "Volume",
id = "ID"
)

data(prostate)
plot_median(
data = prostate,
group = "Genotype",
time = "Age",
measure = "BLI",
id = "ID"
)
```
