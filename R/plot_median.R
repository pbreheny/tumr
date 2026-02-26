#' Process data to be used in plot_median
#'
#' @param time vector of time measurements
#' @param measure vector of tumor growth measurements
#'
#' @return Processed Data

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
 #' @param tumr_obj takes tumr_obj created by tumr()
 #'
 #' @return A plot
 #'
 #' @examples
 #' data(melanoma1)
 #' mel1 <- tumr(melanoma1, ID, Day, Volume, Treatment)
 #' plot_median(
 #' tumr_obj = mel1
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


 plot_median <- function(tumr_obj = NULL, data = NULL, group = NULL, time = NULL, measure = NULL, id = NULL) {

   if (!is.null(tumr_obj)) {
     if (is.null(id)) id <- tumr_obj$id
     if (is.null(time)) time <- tumr_obj$time
     if (is.null(measure)) measure <- tumr_obj$measure
     if (is.null(group)) group <- tumr_obj$group
     if (is.null(data)) data <- tumr_obj$data
   }

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
           MedianVolume = median_volume
         )


     }) |>
     dplyr::ungroup()

   # Plot
    data_ind <- data |>
      dplyr::filter(!is.na(.data[[measure]]))

    data_sum <- summary_data |>
     dplyr::filter(!is.na(summary_data$MedianVolume))

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


 }

