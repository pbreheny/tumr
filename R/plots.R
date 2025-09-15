
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


#plot.rfeat

plot.rfeat <- function (x) {

  ggplot2::ggplot(x$betas, ggplot2::aes(x = Group, y = Beta, color = Group)) +
  ggplot2::geom_jitter(width = 0.2, size = 2) +
  ggplot2::stat_summary(fun = mean, geom = "point", shape = 18, size = 4, color = "black") +
  ggplot2::labs(title = "Individual Slopes (Betas) by Group",
                y = paste("Slope of", x$relevant_information["Measure"], "vs", x$relevant_information["Time"]),
                x = x$relevant_information["Group"]) +
  ggplot2::theme_minimal()

}

example <- rfeat(breast, "ID", "Week", "Volume", "Treatment", transformation = log1p, comparison = "t.test")

plot.rfeat(example)


