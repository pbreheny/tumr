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
  id <- as.character(substitute(id))
  time <- as.character(substitute(time))
  measure <- as.character(substitute(measure))
  group <- as.character(substitute(group))
  if (!all(c(id, time, measure, group) %in% names(data))) {
    stop("Specified columns not found in data.", call. = FALSE)
  }
  # check time scale
  time_values <- data[[time]]
  if (is.numeric(time_values) &&
      any(!is.na(time_values)) &&
      diff(range(time_values, na.rm = TRUE)) > 50) {
    warning(
      paste0(
        "\n--------------------------------------------------------------------\n",
        "The time range is greater than 50, which may cause convergence\n",
        "issues when fitting lmm(). Consider rescaling the time variable\n",
        "to a larger unit (e.g., from days to weeks or months).\n",
        "--------------------------------------------------------------------"
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