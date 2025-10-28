#' Create tumr object
#'
#' @param data Data frame
#' @param id  Column of subject ID's
#' @param time Column of repeated time measurements
#' @param measure Column of repeated measurements of tumor
#' @param group Column specifying the treatment group for each measurement
#'
#' @return A tumr object
#'
#' @examples
#' data(breast)
#' tumr(breast, ID, Week, Volume, Treatment)
#'
#' @export


tumr <- function(data, id, time, measure, group){
  id <- deparse(substitute(id))
  time <- deparse(substitute(time))
  measure <- deparse(substitute(measure))
  group <- deparse(substitute(group))

  meta_data <- list(
    id = id,
    time = time,
    measure = measure,
    group = group,
    data = data
  )


  #returns tumr object but would need to be saved to use
  #problem would be that it might have different names
  return(meta_data)

  #creates tumr object for user and goes straight to environment
  #tumr_obj <<- meta_data

  class(meta_data) <- "tumr"
}


