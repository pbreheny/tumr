
#Breast Data

#NA values ignored

breast_summary <- breast |>
  dplyr::group_by(Treatment, Week) |>
  dplyr::summarise(Volume = median(Volume)) |>
  dplyr::ungroup()

ggplot2::ggplot() +
  ggplot2::geom_line(data = breast, ggplot2::aes(x = Week, y = Volume, group = ID), alpha = 0.3)  +
  ggplot2::geom_line(data = breast_summary, ggplot2::aes(x = Week, y = Volume, color = Treatment), linewidth = 1.2)

#log transformed data

breast_2 <- breast |>
  dplyr::mutate(log_y = log1p(Volume))

breast_summary <- breast |>
  dplyr::mutate(log_y = log1p(Volume)) |>
  dplyr::group_by(Treatment, Week) |>
  dplyr::summarise(log_y = mean(log_y)) |>
  dplyr::ungroup()

ggplot2::ggplot() +
  ggplot2::geom_line(data = breast_2, ggplot2::aes(x = Week, y = log_y, group = ID), alpha = 0.3)  +
  ggplot2::geom_line(data = breast_summary, ggplot2::aes(x = Week, y = log_y, color = Treatment), linewidth = 1.2)



breast_exp <- breast |>
  mutate(log_y = log1p(Volume))




#default summary measure is the median

plots <- function(data, group, time, measure, id){
  data_summary <- data |>
    dplyr::group_by({{group}}, {{time}}) |>
    dplyr::summarise(measure = median({{measure}}, na.rm = TRUE)) |>
    dplyr::ungroup()

  ggplot2::ggplot() +
    ggplot2::geom_line(data = data, ggplot2::aes(x = {{time}}, y = {{measure}}, group = {{id}}), alpha = 0.3)  +
    ggplot2::geom_line(data = data_summary, ggplot2::aes(x = {{time}}, y = measure, color = {{group}}), linewidth = 1.2)

}

plots(breast, Treatment, Week, Volume, ID)
plots(melanoma1, Treatment, Day, Volume, ID)
plots(melanoma2, Treatment, Day, Volume, ID)
plots(prostate, Genotype, Age, BLI, ID)
