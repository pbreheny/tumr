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
transformation = log1p,
comparison = "t.test")
#> Error in rfeat(data = breast, id = "ID", time = "Week", measure = "Volume",     group = "Treatment", transformation = log1p, comparison = "t.test"): unused argument (transformation = log1p)
plot(example)
#> Warning: no help found for ‘x’
#> Error in curve(expr = x, from = from, to = to, xlim = xlim, ylab = ylab,     ...): 'expr' did not evaluate to an object of length 'n'
```
