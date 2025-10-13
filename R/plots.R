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
    ggplot2::geom_line(data = data_full,
                       ggplot2::aes(x = {{time}},
                                    y = {{measure}},
                                    group = {{id}},
                                    color = {{group}}),
                       alpha = 0.5)  +
    ggplot2::geom_line(data = data_summary,
                       ggplot2::aes(x = {{time}},
                                    y = measure,
                                    color = {{group}}),
                       linewidth = 1.2)

}

#' Plot of tumor growth over time
#'
#' @param time vector of time measurements
#' @param measure vector of tumor growth measurements
#'
#' @return Processed Data
#'
#' @export

process_data <- function(time, measure) {

  if (all(is.na(measure))) {
    stop("Must have at least one non-missing value.")
  }

  # Identify NA positions
  na_indices <- which(is.na(measure))

  # Copy for cleaned output
  measure_clean <- measure

  # Find last non-NA index
  last_val_index <- max(which(!is.na(measure)))

  # Step 1: Interpolate embedded NAs
  if (length(na_indices) > 0) {
    interp_fun <- approxfun(
      x = time[!is.na(measure)],
      y = measure[!is.na(measure)],
      rule = 1
    )

    for (i in na_indices) {
      if (i <= last_val_index) {
        # Interpolate only embedded NAs
        measure_clean[i] <- interp_fun(time[i])
      }
    }

    # Step 2: Fill trailing NAs with last non-NA value
    if (last_val_index < length(measure)) {
      measure_clean[(last_val_index + 1):length(measure)] <- measure[last_val_index]
    }
  }

  # Step 3: Construct missing vector
  missing_vector <- rep(1, length(measure))
  if (last_val_index < length(measure)) {
    missing_vector[(last_val_index + 1):length(measure)] <- 0
  }

  return(list(
    data_no_missing_values = measure_clean,
    missing_vector = missing_vector
  ))
}



 #' Plot of tumor growth over time using the median
 #'
 #' @param data  tumor growth data
 #' @param id  Column of subject ID's
 #' @param time Column of repeated time measurements
 #' @param measure Column of repeated measurements of tumor
 #' @param group Column specifying the treatment group for each measurement
 #' @param type type of plot produced
 #'
 #' @return A plot
 #'
 #' @examples
 #' data(breast)
 #' plot_median(
 #' data = breast,
 #' group = "Treatment",
 #' time = "Week",
 #' measure = "Volume",
 #' id = "ID"
 #' )
 #' data(melanoma1)
 #' plot_median(
 #' data = melanoma1,
 #' group = "Treatment",
 #' time = "Day",
 #' measure = "Volume",
 #' id = "ID",
 #' type = "conf_int"
 #' )
 #' data(melanoma2)
 #' plot_median(
 #' data = melanoma2,
 #' group = "Treatment",
 #' time = "Day",
 #' measure = "Volume",
 #' id = "ID"
 #' )
 #' data(prostate)
 #' plot_median(
 #' data = prostate,
 #' group = "Genotype",
 #' time = "Age",
 #' measure = "BLI",
 #' id = "ID"
 #' )
 #' @export


 plot_median <- function(data, group, time, measure, id, type = "spaghetti") {

   #adding in missing rows
   data <- data |>
     tidyr::complete(.data[[id]], .data[[time]]) |>
     dplyr::group_by(.data[[id]]) |>
     tidyr::fill(.data[[group]], .direction = "down")


   # Compute survival-adjusted medians using process_data()
   processed_data <- data |>
     dplyr::group_by(.data[[id]]) |>
     dplyr::group_modify(~ {
       processed <- process_data(.x[[time]], .x[[measure]])

       surv_list <- base::mapply(
         FUN = function(time, event) survival::Surv(time, event),
         time = processed$data_no_missing_values,
         event = processed$missing_vector,
         SIMPLIFY = FALSE
       )

       tibble::tibble(
         !!id := .x[[id]],
         !!group := .x[[group]],
         !!time := .x[[time]],
         SurvObj = surv_list
       )
     }) |>
     dplyr::ungroup()

   # Compute survival-adjusted medians per group + time
   summary_data <- processed_data |>
     dplyr::group_by(.data[[time]], .data[[group]]) |>
     dplyr::group_modify(~ {
       surv_vec <- base::do.call("c", .x$SurvObj)

         surv_fit <- survival::survfit(surv_vec ~ 1)

         fit_table <- summary(surv_fit)$table

         median_volume <- fit_table["median"]
         lower_ci <- fit_table["0.95LCL"]
         upper_ci <- fit_table["0.95UCL"]

         tibble::tibble(
           MedianVolume = median_volume,
           CI_Lower = lower_ci,
           CI_Upper = upper_ci
         )


     }) |>
     dplyr::ungroup()

   # Plot
    data_ind <- data |>
      dplyr::filter(!is.na(.data[[measure]]))

    data_sum <- summary_data |>
     dplyr::filter(!is.na(summary_data$MedianVolume)) |>
     dplyr::mutate(CI_Lower = tidyr::replace_na(CI_Lower, 0),
                   CI_Upper = tidyr::replace_na(CI_Upper, Inf))

    if(type == "spaghetti") {
      ggplot2::ggplot() +
          ggplot2::geom_line(
            data = data_ind,
            ggplot2::aes(
              x = .data[[time]],
              y = .data[[measure]],
              group = .data[[id]],
              color = .data[[group]]
            ),
            alpha = 0.5
          ) +
          ggplot2::geom_line(
            data = data_sum,
            ggplot2::aes(
              x = .data[[time]],
              y = .data[["MedianVolume"]],
              color = .data[[group]]
            ),
            linewidth = 1.2
          ) +
          ggplot2::labs(
            y = "Volume",
            title = "Volume over Time"
          )
    } else if(type == "conf_int"){
      ggplot2::ggplot() +
        ggplot2::geom_line(
          data = data_sum,
          ggplot2::aes(
            x = .data[[time]],
            y = .data[["MedianVolume"]],
            color = .data[[group]]
          ),
          linewidth = 1.2
        ) +
        ggplot2::geom_ribbon(
          data = data_sum,
          ggplot2::aes(
            x = .data[[time]],
            ymin = CI_Lower,
            ymax = CI_Upper,
            fill = .data[[group]]
          ),
          alpha = 0.3
        ) +
        ggplot2::labs(
          y = "Volume",
          title = "Volume over Time"
        )
    }

   #print(summary_data)
   #print(data_sum)
   #print(data)

 }

