# Summary of a GAM Fit for Tumor Growth Data

Returns the full `mgcv` GAM summary and pairwise group comparisons via
`emmeans::pairs()`.

## Usage

``` r
# S3 method for class 'tumr_gam'
summary(object, adjust.method = "holm", ...)
```

## Arguments

- object:

  An object of class `"tumr_gam"`.

- adjust.method:

  P-value adjustment method passed to `emmeans::pairs()`. Default
  `"holm"`.

- ...:

  Currently ignored.

## Value

An object of class `"summary.tumr_gam"` with components:

- `gam_summary`:

  Full
  [`mgcv::summary.gam`](https://rdrr.io/pkg/mgcv/man/summary.gam.html)
  output.

- `pairwise_tests`:

  Data frame of pairwise Wald test results with adjusted p-values.

- `adjust.method`:

  The adjustment method used.

- `relevant_info`:

  Column name metadata.
