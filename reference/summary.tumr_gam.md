# Summary of a GAM Fit for Tumor Growth Data

Summary of a GAM Fit for Tumor Growth Data

## Usage

``` r
# S3 method for class 'tumr_gam'
summary(object, ...)
```

## Arguments

- object:

  An object of class `"tumr_gam"` returned by
  [`gam`](https://pbreheny.github.io/tumr/reference/gam.md).

- ...:

  Currently ignored.

## Value

A list with components:

- `parametric_coefficients`:

  Group effect estimates with Holm- and Hommel-adjusted p-values.

- `smooth_terms`:

  Smooth term significance table.

- `gam_summary`:

  Full GAM summary from `mgcv`.

- `mer_summary`:

  Mixed-effects summary from `lme4`.
