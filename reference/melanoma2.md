# Tumor growth data for a melanoma cancer model (451LuBR)

The 451LuBR cell line (metastatic melanoma) was used to create CDX (Cell
Line Derived Xenograft) mice.

## Usage

``` r
melanoma2
```

## Format

A data frame with 568 rows and 4 variables:

- ID:

  Mouse identifier to indicate repeated measurements on the same mouse.
  (factor)

- Day:

  Day of measurment (integer)

- Volume:

  Tumor volume (double)

- Treatment:

  Treatment group (factor). A = control, B = PB-212 (lead), C = PLX4032
  (BRAF inhibitor), D = PLX4032 + PBA (4-Phenylbutyric acid), E =
  PB-212 + PLX4032 + PBA.

## Source

University of Iowa, Holden Cancer Center, experiment GJZ16-091.
