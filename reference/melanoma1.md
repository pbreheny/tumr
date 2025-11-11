# Tumor growth data for a melanoma cancer model (A375)

The A375 cell line (metastatic melanoma) was used to create CDX (Cell
Line Derived Xenograft) mice.

## Usage

``` r
melanoma1
```

## Format

A data frame with 600 rows and 4 variables:

- ID:

  Mouse identifier to indicate repeated measurements on the same mouse.
  (factor)

- Day:

  Day of measurment (integer)

- Volume:

  Tumor volume (double)

- Treatment:

  Treatment group (factor). A = control, B = Vemurafenib (BRAF
  inhibitor), C = Buthionine sulfoximine (BSO), D = Vemurafenib + BSO.

## Source

University of Iowa, Holden Cancer Center, experiment SLB19-022.
