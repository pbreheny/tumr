#' Prints relevant output from lmm
#'
#' @param x lmm object
#' @param ... Other parameters
#'
#' @returns relevant output
#'
#' @export
print.lmm <- function(x, ...){
  print(x$model)
}