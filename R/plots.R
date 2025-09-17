#' Plot of tumor growth over time
#'
#' @param data  tumor growth data
#' @param id  Column of subject ID's
#' @param time Column of repeated time measurements
#' @param measure Column of repeated measurements of tumor
#' @param group Column specifying the treatment group for each measurement
#' @param stat method of data summary for each group
#' @param remove_na removes NA values in measure column before plotting
#'
#' @return A plot
#'
#' @examples
#' data(breast)
#' plots(breast, Treatment, Week, Volume, ID, stat = median, remove_na = FALSE)
#' plots(breast, Treatment, Week, Volume, ID, remove_na = TRUE)
#' data(melanoma1)
#' plots(melanoma1, Treatment, Day, Volume, ID)
#' @export

plots <- function(data, group, time, measure, id, stat = median, remove_na = FALSE){
  data_summary <- data |>
    dplyr::group_by({{group}}, {{time}}) |>
    dplyr::summarise(measure = stat({{measure}}, na.rm = remove_na), .groups = "drop_last") |>
    dplyr::ungroup()

  if (remove_na == TRUE){
    data_full <- data |>
      na.omit(data)
  } else {
    data_full <- data
  }

  ggplot2::ggplot() +
    ggplot2::geom_line(data = data_full, ggplot2::aes(x = {{time}}, y = {{measure}}, group = {{id}}), alpha = 0.3)  +
    ggplot2::geom_line(data = data_summary, ggplot2::aes(x = {{time}}, y = measure, color = {{group}}), linewidth = 1.2)

}






