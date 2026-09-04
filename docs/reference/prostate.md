# Tumor growth data for a prostate cancer model

In this experiment, 49 mice were split into 3 groups. All of the groups
have Pten, a cancer gene, knocked out of their prostates. One group had
normal p53, one group had one copy of the p53 knocked out, and the third
group had both copies of p53 knocked out of their prostates. These mice
also had a bioluminescent reporter so that tumor progression could be
monitored by imaging.

## Usage

``` r
prostate
```

## Format

A data frame with 336 rows and 6 variables:

- ID:

  Mouse identifier to indicate repeated measurements on the same mouse.
  (factor)

- Age:

  Age of the mouse, in weeks (integer)

- BLI:

  Tumor volume, as measured by bioluminescent imaging, in photons
  (double)

- Genotype:

  p53 genotype (factor). WT = wild type, HET = single knockout, DOKO =
  double knockout.

## Source

https://doi.org/10.1371/journal.pone.0232807
