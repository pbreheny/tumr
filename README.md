# tumr

<!-- badges: start -->
[![GitHub version](https://img.shields.io/static/v1?label=GitHub&message=0.6.0&color=blue&logo=github)](https://github.com/pbreheny/tumr)
[![R-CMD-check](https://github.com/pbreheny/tumr/workflows/R-CMD-check/badge.svg)](https://github.com/pbreheny/tumr/actions)
<!-- badges: end -->

tumr is a collection of tools for analyzing tumor growth data. 

An example of how to use tumr can be seen in the [Get Started](https://pbreheny.github.io/tumr/articles/tumr.html) page.

**tumr** includes:

+ **tumr()** - creates a tumr object that can be passed into **plot_median()**, **rfeat()**, and **lmm()**.

+ **plot_median()** - creates a spaghetti plot and plots the median tumor growth 
measurement for each treatment group.

+ **rfeat()** - tests whether the beta coefficients (slope of tumor measure over time) 
of individuals in different treatment groups are different from each other using 
either t-test, ANOVA, Tukey, or both ANOVA and Tukey.
  - rfeat() has a **plot()** function that shows the individual beta coefficients and mean slope by treatment 
group. 

+ **lmm()** - fits a linear mixed model with the default formula of 
log1p(Volume) ~ Treatment * scale(Day) + (scale(Day) | ID) where the time variable
is centered.
  - lmm() includes a **summary()** function that provides the overall effect
of time averaged over the levels of the treatment group, the slope of treatment
over time for each treatment group, and the results of a contrast to test the 
slope differences between the treatment groups.
  - lmm() includes a **plot()** function that shows the predicted values of the tumor growth measurements over time 
and the mean slope for each treatment with their 95% confidence intervals.

+ **bhm()** - fits a Bayesian Hierarchical Linear Model.
  - bhm() includes a **summary()** function that provides the treatment-specific intercepts with exponential transformation
  , treatment-specific slopes with exponential transformation, and pairwise treatment contrasts in slopes with exponential transformation.
  - bhm() includes a **plot()** function that shows the the mean slope for each treatment with their 90% credible intervals,
  Pairwise slope contrasts with their 90% credible intervals, and MCMC trace plots for model diagnostics.

### How to install tumr

To install tumr, copy and paste the following code into the console

```
if (!requireNamespace("remotes")) install.packages("remotes")
remotes::install_github("pbreheny/tumr")
```
