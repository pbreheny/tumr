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
#' @param tumr_obj takes tumr_obj created by tumr()
#' @param data tumor growth data
#' @param group Column specifying the treatment group for each measurement
#' @param time Column of repeated time measurements
#' @param measure Column of repeated measurements of tumor
#' @param id Column of subject ID's
#' @param par Logical. If `TRUE`, uses the parametric method. If `FALSE`,
#' uses the nonparametric method based on Kaplan-Meier
#' estimation. Default is `TRUE`.
#'
#' @return A ggplot object
#'
#' @examples
#' data(melanoma2)
#' mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
#' plot_median(mel2)
#' plot_median(mel2, par = FALSE)
#'
#' @export
#'

plot_median <- function(tumr_obj = NULL, data = NULL, group = NULL,
                        time = NULL, measure = NULL, id = NULL,
                        par = TRUE) {

  if (!is.null(tumr_obj)) {
    if (is.null(id)) id <- tumr_obj$id
    if (is.null(time)) time <- tumr_obj$time
    if (is.null(measure)) measure <- tumr_obj$measure
    if (is.null(group)) group <- tumr_obj$group
    if (is.null(data)) data <- tumr_obj$data
  }

  data <- data |>
    tidyr::complete(!!rlang::sym(id), !!rlang::sym(time)) |>
    dplyr::group_by(.data[[id]]) |>
    tidyr::fill(!!rlang::sym(group), .direction = "down") |>
    dplyr::ungroup()

  if (par) {
    processed_data <- data |>
      dplyr::group_by(.data[[id]]) |>
      dplyr::group_modify(~ {
        processed <- process_data(.x[[time]], .x[[measure]])
        tibble::tibble(
          !!time := .x[[time]],
          !!group := .x[[group]],
          !!id := .x[[id]],
          volume = processed$data_no_missing_values,
          event = processed$missing_vector
        )
      }) |>
      dplyr::ungroup()

    group_size <- processed_data |>
      dplyr::distinct(.data[[group]], .data[[id]]) |>
      dplyr::count(.data[[group]], name = "group_n")

    summary_data <- processed_data |>
      dplyr::group_by(.data[[time]], .data[[group]]) |>
      dplyr::group_modify(~ {
        observed_n <- sum(.x$event == 1, na.rm = TRUE)
        censored_n <- sum(.x$event == 0, na.rm = TRUE)

        if (observed_n < 2) {
          return(tibble::tibble(
            MedianVolume = NA_real_,
            observed_n = observed_n,
            censored_n = censored_n
          ))
        }

        surv_vec <- survival::Surv(.x$volume, .x$event)

        fit <- tryCatch(
          survival::survreg(surv_vec ~ 1, dist = "lognormal"),
          error = function(e) NULL
        )

        if (is.null(fit)) {
          return(tibble::tibble(
            MedianVolume = NA_real_,
            observed_n = observed_n,
            censored_n = censored_n
          ))
        }

        median_volume <- exp(coef(fit)[["(Intercept)"]])

        tibble::tibble(
          MedianVolume = median_volume,
          observed_n = observed_n,
          censored_n = censored_n
        )
      }) |>
      dplyr::ungroup() |>
      dplyr::left_join(group_size, by = group) |>
      dplyr::arrange(.data[[group]], .data[[time]]) |>
      dplyr::group_by(.data[[group]]) |>
      dplyr::mutate(
        stop_curve = (censored_n / group_n) >= 0.6,
        stop_after = cumsum(stop_curve) > 0,
        MedianVolume = dplyr::if_else(stop_after, NA_real_, MedianVolume)
      ) |>
      dplyr::ungroup()

    plot_title <- "Volume over Time (Log-Normal MLE Median)"
  } else {
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

    summary_data <- processed_data |>
      dplyr::group_by(.data[[time]], .data[[group]]) |>
      dplyr::group_modify(~ {
        surv_vec <- base::do.call("c", .x$SurvObj)

        surv_fit <- survival::survfit(surv_vec ~ 1)
        fit_table <- summary(surv_fit)$table

        median_volume <- fit_table["median"]

        tibble::tibble(
          MedianVolume = median_volume
        )
      }) |>
      dplyr::ungroup()

    plot_title <- "Volume over Time"
  }

  data_ind <- data |>
    dplyr::filter(!is.na(.data[[measure]]))

  data_sum <- summary_data |>
    dplyr::filter(!is.na(MedianVolume))

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
      title = plot_title
    )
}