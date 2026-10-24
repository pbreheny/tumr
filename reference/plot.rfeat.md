# Plot based on rfeat analysis

Plot based on rfeat analysis

## Usage

``` r
# S3 method for class 'rfeat'
plot(x, ...)
```

## Arguments

- x:

  An rfeat object

- ...:

  Other parameters

## Value

A plot

## Examples

``` r
data(breast)
breast_obj <- tumr(breast, ID, Week, Volume, Treatment)
example <- rfeat(breast_obj, comparison = "t.test")
plot(example)

```
