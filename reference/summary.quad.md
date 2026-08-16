# Summary of a Quadratic Mixed Model Fit

Returns the full linear mixed-model summary and pairwise treatment
comparisons based on estimated marginal means.

## Usage

``` r
# S3 method for class 'quad'
summary(object, ...)
```

## Arguments

- object:

  An object of class `"quad"`.

- ...:

  Currently ignored.

## Value

An object of class `"summary.quad"` containing:

- `model_summary`:

  Full summary of the fitted linear mixed model.

- `pairwise_tests`:

  Pairwise treatment comparisons with Holm-adjusted p-values.
