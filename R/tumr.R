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
  # check time scale
  time_values <- data[[time]]
  if (is.numeric(time_values) &&
      any(!is.na(time_values)) &&
      diff(range(time_values, na.rm = TRUE)) > 50) {
    warning(
      paste0(
        "\n----------------------------------------------------------------------\n",
        "The range of the time variable is greater than 50, which may ",
        "cause convergence issues when fitting lmm().\n",
        "Consider rescaling time to a larger unit ",
        "(for example, from days to weeks or months).\n",
        "----------------------------------------------------------------------"
      ),
      call. = FALSE
    )
  }
  meta_data <- list(
    id = id,
    time = time,
    measure = measure,
    group = group,
    data = data
  )
  class(meta_data) <- "tumr"
  return(meta_data)
}