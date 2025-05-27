#' Tumor growth data for a melanoma cancer model (A375)
#'
#' The A375 cell line (metastatic melanoma) was used to create CDX (Cell Line
#' Derived Xenograft) mice.
#'
#' @format A data frame with 600 rows and 4 variables:
#' \describe{
#'   \item{ID}{Mouse identifier to indicate repeated measurements on the same mouse. (factor)}
#'   \item{Day}{Day of measurment (integer)}
#'   \item{Volume}{Tumor volume (double)}
#'   \item{Treatment}{Treatment group (factor).
#'     A = control,
#'     B = Vemurafenib (BRAF inhibitor),
#'     C = Buthionine sulfoximine (BSO),
#'     D = Vemurafenib + BSO.
#'   }
#' }
#' @source University of Iowa, Holden Cancer Center, experiment SLB19-022.
"melanoma1"

#' Tumor growth data for a melanoma cancer model (451LuBR)
#'
#' The 451LuBR cell line (metastatic melanoma) was used to create CDX (Cell Line
#' Derived Xenograft) mice.
#'
#' @format A data frame with 568 rows and 4 variables:
#' \describe{
#'   \item{ID}{Mouse identifier to indicate repeated measurements on the same mouse. (factor)}
#'   \item{Day}{Day of measurment (integer)}
#'   \item{Volume}{Tumor volume (double)}
#'   \item{Treatment}{Treatment group (factor).
#'     A = control,
#'     B = PB-212 (lead),
#'     C = PLX4032 (BRAF inhibitor),
#'     D = PLX4032 + PBA (4-Phenylbutyric acid),
#'     E = PB-212 + PLX4032 + PBA.
#'   }
#' }
#' @source University of Iowa, Holden Cancer Center, experiment GJZ16-091.
"melanoma2"

#' Tumor growth data for a breast cancer model
#'
#' In this strain of rat, tumors begin to appear about 6 weeks after carcinogen
#' and are followed for another 6 weeks. The goal of the study is to estimate
#' the effects of nicotinamide riboside (a dietary supplement) on growth of
#' mammary gland tumors.
#'
#' @format A data frame with 336 rows and 6 variables:
#' \describe{
#'   \item{ID}{Mouse identifier to indicate repeated measurements on the same mouse. (factor)}
#'   \item{Cohort}{Indicator of which cohort the mouse belonged to, in order to
#'     account for potential batch effects. (factor)}
#'   \item{Treatment}{Treatment group (factor).
#'     VEH = control (vehicle),
#'     NR = nicotinamide riboside
#'   }
#'   \item{Week}{Week of measurment (integer)}
#'   \item{Volume}{Tumor volume, in cubic mm (double)}
#'   \item{Number}{Number of tumors (integer)}
#' }
#' @source University of Iowa, Holden Cancer Center, experiment PJB17-025.
"breast"

#' Tumor growth data for a prostate cancer model
#'
#' In this experiment, 49 mice were split into 3 groups. All of the groups have
#' Pten, a cancer gene, knocked out of their prostates. One group had normal p53,
#' one group had one copy of the p53 knocked out, and the third group had both
#' copies of p53 knocked out of their prostates. These mice also had a
#' bioluminescent reporter so that tumor progression could be monitored by imaging.
#'
#' @format A data frame with 336 rows and 6 variables:
#' \describe{
#'   \item{ID}{Mouse identifier to indicate repeated measurements on the same mouse. (factor)}
#'   \item{Age}{Age of the mouse, in weeks (integer)}
#'   \item{BLI}{Tumor volume, as measured by bioluminescent imaging, in photons (double)}
#'   \item{Genotype}{p53 genotype (factor).
#'     WT = wild type,
#'     HET = single knockout,
#'     DOKO = double knockout.
#'   }
#' }
#' @source https://doi.org/10.1371/journal.pone.0232807
"prostate"
