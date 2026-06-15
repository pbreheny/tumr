# tumr

tumr is a collection of tools for analyzing tumor growth data.

An example of how to use tumr can be seen in the [Get
Started](https://pbreheny.github.io/tumr/articles/tumr.html) page.

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

- **bhm()** - fits a Bayesian Hierarchical Linear Model.

  - bhm() includes a **summary()** function that provides the
    treatment-specific intercepts with exponential transformation ,
    treatment-specific slopes with exponential transformation, and
    pairwise treatment contrasts in slopes with exponential
    transformation.
  - bhm() includes a **plot()** function that shows the the mean slope
    for each treatment with their 90% credible intervals, Pairwise slope
    contrasts with their 90% credible intervals, and MCMC trace plots
    for model diagnostics.

- **dtime()** - Compute the Tumor Doubling Time based on fitted model.
  This function is available for both **lmm()** and **bhm** object.

- **quad()** - fits a Quadratic Linear Mixed Model.

  - quad() includes a plot() function that shows pairwise treatment
    contrasts over time with their confidence intervals.

- **gamFit()** - fits a Generalized Additive Model.

  - gam() includes a **summary()** function that provides the GAM model
    summary including pairwise treatment comparisons based on estimated
    marginal means.
  - gam() includes a **plot()** function that shows the fitted tumor
    growth curves for each treatment group with their 95% confidence
    intervals, as well as pairwise treatment contrasts over time with
    their 95% confidence intervals.

- **check_exp()** - checks the exponential growth assumption for tumor
  growth models.

  - check_exp() generates residual diagnostic plots from an **lmm()**
    object fitted to log-transformed tumor volume.
  - check_exp() provides residuals versus time and residuals versus
    fitted values plots by treatment group to assess systematic model
    misspecification.
  - check_exp() also provides a QQ plot of residuals to evaluate the
    normality assumption of the fitted linear mixed model.

### How to install tumr

To install tumr, copy and paste the following code into the console

    if (!requireNamespace("remotes")) install.packages("remotes")
    remotes::install_github("pbreheny/tumr")
