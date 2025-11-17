# tumr

tumr is a collection of tools for analyzing tumor growth data.

An example of how to use tumr can be seen under the [Get
Started](https://pbreheny.github.io/tumr/vignettes/tumr.qmd) tab.

**tumr** includes:

- **tumr()** - creates a tumr object that can be passed into
  **plot_median()**, **rfeat()**, and **lmm()**.

- **plot_median()** - creates a spaghetti plot and plots the median
  tumor growth measurement for each treatment group.

- **rfeat()** - tests whether the beta coefficients (slope of tumor
  measure over time) of individuals in different treatment groups are
  different from each other using either t-test, ANOVA, Tukey, or both
  ANOVA and Tukey.

  - rfeat() has a **plot()** function that shows the individual beta
    coefficients and mean slope by treatment group.

- **lmm()** - fits a linear mixed model with the default formula of
  log1p(Volume) ~ Treatment \* scale(Day) + (scale(Day) \| ID) where the
  time variable is centered.

  - lmm() includes a **summary()** function that provides the overall
    effect of time averaged over the levels of the treatment group, the
    slope of treatment over time for each treatment group, and the
    results of a contrast to test the slope differences between the
    treatment groups.
  - lmm() includes a **plot()** function that shows the predicted values
    of the tumor growth measurements over time and the mean slope for
    each treatment with their 95% confidence intervals.

### How to install tumr

To install tumr, copy and paste the following code into the console

    if (!requireNamespace("remotes")) install.packages("remotes")
    remotes::install_github("pbreheny/tumr")
