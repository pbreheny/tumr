

#default summary measure is the median
#drop_last in summarise all the time or option?

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

plots(breast, Treatment, Week, Volume, ID, stat = median, remove_na = FALSE)
plots(breast, Treatment, Week, Volume, ID, remove_na = TRUE)
plots(melanoma1, Treatment, Day, Volume, ID)
plots(melanoma2, Treatment, Day, Volume, ID)
plots(prostate, Genotype, Age, BLI, ID)





