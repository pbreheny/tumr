#' Prints relevant output from rfeat
#'
#' @param x rfeat object
#' @param ... Other parameters
#'
#' @return relevant output
#'
#' @export

print.rfeat <- function(x, ...){
  print(x$test)
}
