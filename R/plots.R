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
#' @param x tumor growth data
#'
#' @return Processed Data
#'
#' @export

 process_data <- function(x){
   y <- x

   if (length(which(is.na(x))) == 0) {
     all_na_at_end <- TRUE
   }
   all_na_at_end <- all(which(is.na(x)) == seq(from = length(x) - length(which(is.na(x))) + 1, to = length(x)))

   if(all_na_at_end != TRUE){
     stop("Cannot have embedded missing values")
   }

   if(all(is.na(x))){
     stop("Must have at least 1 non-missing value")
   }

   last_val_index <- max(which(!is.na(x)))
   last_val <- x[last_val_index]

   if (last_val_index < length(x)) {
     x[(last_val_index + 1):length(x)] <- last_val
   }

   if(length(which(is.na(y))) == 0){
     y[(1:length(y))] <- 1
   } else {
     y[(last_val_index + 1):length(x)] <- 0
     y[(1:last_val_index)] <- 1
   }

   return(list(
     data_no_missing_values = x,
     missing_vector = y
   ))
 }


 #' Plot of tumor growth over time using the median
 #'
 #' @param data  tumor growth data
 #' @param id  Column of subject ID's
 #' @param time Column of repeated time measurements
 #' @param measure Column of repeated measurements of tumor
 #' @param group Column specifying the treatment group for each measurement
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
 #' id = "ID"
 #' )
 #' @export


 plot_median <- function(data, group, time, measure, id) {

   #adding in missing rows
   # data <- data |>
   #   tidyr::complete(.data[[id]], .data[[time]]) |>
   #   dplyr::group_by(.data[[id]]) |>
   #   tidyr::fill(.data[[group]], .direction = "down")

   all_combos <- expand.grid(
     temp_id = unique(data[[id]]),
     temp_time = unique(data[[time]])
   )
   names(all_combos) <- c(id, time)
   data <- merge(all_combos, data, by = c(id, time), all.x = TRUE)
   data <- data[order(data[[id]], data[[time]]), ]
   data[[group]] <- ave(
     data[[group]],
     data[[id]],
     FUN = function(x) {
       for (i in seq_along(x)) {
         if (is.na(x[i]) && i > 1) {
           x[i] <- x[i - 1]
         }
       }
       x
     }
   )

   # Compute survival-adjusted medians using process_data()
   processed_data <- data |>
     dplyr::group_by(.data[[id]]) |>
     dplyr::group_modify(~ {
       processed <- process_data(.x[[measure]])

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
         # median_volume <- stats::quantile(surv_fit, probs = 0.5)$quantile
         #
         # tibble::tibble(MedianVolume = median_volume)

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
   ggplot2::ggplot() +
     ggplot2::geom_line(
       data = data,
       ggplot2::aes(
         x = .data[[time]],
         y = .data[[measure]],
         group = .data[[id]],
         color = .data[[group]]
       ),
       alpha = 0.5
     ) +
     ggplot2::geom_line(
       data = summary_data,
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

   #print(summary_data)
   #print(data)

 }


