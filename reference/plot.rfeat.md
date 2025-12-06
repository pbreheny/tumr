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
example <- rfeat(data = breast,
id = "ID",
time = "Week",
measure = "Volume",
group = "Treatment",
comparison = "t.test")
plot(example)
```
