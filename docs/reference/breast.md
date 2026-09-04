# Tumor growth data for a breast cancer model

In this strain of rat, tumors begin to appear about 6 weeks after
carcinogen and are followed for another 6 weeks. The goal of the study
is to estimate the effects of nicotinamide riboside (a dietary
supplement) on growth of mammary gland tumors.

## Usage

``` r
breast
```

## Format

A data frame with 336 rows and 6 variables:

- ID:

  Mouse identifier to indicate repeated measurements on the same mouse.
  (factor)

- Cohort:

  Indicator of which cohort the mouse belonged to, in order to account
  for potential batch effects. (factor)

- Treatment:

  Treatment group (factor). VEH = control (vehicle), NR = nicotinamide
  riboside

- Week:

  Week of measurment (integer)

- Volume:

  Tumor volume, in cubic mm (double)

- Number:

  Number of tumors (integer)

## Source

University of Iowa, Holden Cancer Center, experiment PJB17-025.
