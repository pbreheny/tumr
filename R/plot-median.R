#' Process data to be used in plot_median
#'
#' @param time vector of time measurements
#' @param measure vector of tumor growth measurements
#'
#' @return A list with cleaned measurements and event indicators
process_data <- function(time, measure) {
  if (all(is.na(measure))) {
    stop("Must have at least one non-missing value.")
  }

  na_indices <- which(is.na(measure))
  measure_clean <- measure
  last_val_index <- max(which(!is.na(measure)))

  # Interpolate embedded missing values
  if (length(na_indices) > 0) {
    interp_fun <- stats::approxfun(
      x = time[!is.na(measure)],
      y = measure[!is.na(measure)],
      rule = 1
    )

    for (i in na_indices) {
      if (i <= last_val_index) {
        measure_clean[i] <- interp_fun(time[i])
      }
    }

    # Carry forward trailing missing values
    if (last_val_index < length(measure)) {
      measure_clean[(last_val_index + 1):length(measure)] <- measure[last_val_index]
    }
  }

  # event = 1 means observed; event = 0 means trailing carried-forward value
  missing_vector <- rep(1, length(measure))
  if (last_val_index < length(measure)) {
    missing_vector[(last_val_index + 1):length(measure)] <- 0
  }

  list(
    data_no_missing_values = measure_clean,
    missing_vector = missing_vector
  )
}


#' Plot tumor volume or fold change over time using median curves
#'
#' @param tumr_obj Optional tumr object created by tumr()
#' @param data Tumor growth data
#' @param group Column specifying treatment group
#' @param time Column of repeated time measurements
#' @param measure Column of repeated tumor measurements
#' @param id Column of subject IDs
#' @param par Logical. If TRUE, use parametric median estimation.
#'   If FALSE, use nonparametric Kaplan-Meier estimation.
#' @param fold Logical. If TRUE, plot fold change instead of raw volume.
#'
#' @return A ggplot object
#'
#' @examples
#' data(melanoma2)
#' mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
#' plot_median(mel2)
#' plot_median(mel2, par = FALSE)
#' plot_median(mel2, fold = TRUE)
#' plot_median(mel2, par = FALSE, fold = TRUE)
#'
#' @export
plot_median <- function(tumr_obj = NULL,
                        data = NULL,
                        group = NULL,
                        time = NULL,
                        measure = NULL,
                        id = NULL,
                        par = TRUE,
                        fold = FALSE) {
  if (!is.null(tumr_obj)) {
    if (is.null(id)) id <- tumr_obj$id
    if (is.null(time)) time <- tumr_obj$time
    if (is.null(measure)) measure <- tumr_obj$measure
    if (is.null(group)) group <- tumr_obj$group
    if (is.null(data)) data <- tumr_obj$data
  }
  if (is.null(data) || is.null(group) || is.null(time) ||
      is.null(measure) || is.null(id)) {
    stop("Please provide data, group, time, measure, and id, or supply tumr_obj.")
  }
  data <- data |>
    tidyr::complete(!!rlang::sym(id), !!rlang::sym(time)) |>
    dplyr::group_by(.data[[id]]) |>
    dplyr::arrange(.data[[time]], .by_group = TRUE) |>
    tidyr::fill(!!rlang::sym(group), .direction = "downup") |>
    dplyr::ungroup()
  processed_data <- data |>
    dplyr::group_by(.data[[id]]) |>
    dplyr::group_modify(~ {
      .x <- .x |>
        dplyr::arrange(.data[[time]])
      processed <- process_data(.x[[time]], .x[[measure]])
      tibble::tibble(
        !!id := .x[[id]],
        !!group := .x[[group]],
        !!time := .x[[time]],
        volume = processed$data_no_missing_values,
        event = processed$missing_vector
      )
    }) |>
    dplyr::ungroup()
  compute_fold_data <- function(df, time_var) {
    df <- df |>
      dplyr::arrange(.data[[time_var]])
    baseline <- df$volume[1]
    if (is.na(baseline)) {
      idx <- which(!is.na(df$volume))[1]
      baseline <- if (!is.na(idx)) df$volume[idx] else NA_real_
    }
    if (is.na(baseline)) {
      df$baseline <- NA_real_
      df$offset <- NA_real_
      df$fold_change <- NA_real_
      return(df)
    }
    if (baseline > 0) {
      offset <- 0
      df$fold_change <- df$volume / baseline
    } else {
      nonzero_vals <- df$volume[df$volume > 0 & !is.na(df$volume)]
      if (length(nonzero_vals) == 0) {
        offset <- 1
      } else {
        offset <- min(nonzero_vals)
      }
      df$fold_change <- (df$volume + offset) / (baseline + offset)
    }
    df$baseline <- baseline
    df$offset <- offset
    df
  }
  analysis_data <- processed_data |>
    dplyr::group_by(.data[[id]]) |>
    dplyr::group_modify(~ compute_fold_data(.x, time_var = time)) |>
    dplyr::ungroup()
  group_size <- analysis_data |>
    dplyr::distinct(.data[[group]], .data[[id]]) |>
    dplyr::count(.data[[group]], name = "group_n")
  get_parametric_volume_summary <- function(df) {
    observed_n <- sum(df$event == 1, na.rm = TRUE)
    censored_n <- sum(df$event == 0, na.rm = TRUE)
    if (observed_n < 2) {
      return(tibble::tibble(
        MedianVolume = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }
    x <- df$volume
    if (any(x < 0, na.rm = TRUE)) {
      return(tibble::tibble(
        MedianVolume = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }
    if (any(x == 0, na.rm = TRUE)) {
      nonzero_vals <- x[x > 0 & !is.na(x)]
      if (length(nonzero_vals) == 0) {
        return(tibble::tibble(
          MedianVolume = 0,
          observed_n = observed_n,
          censored_n = censored_n
        ))
      }
      offset <- min(nonzero_vals)
      y <- log(x + offset)
      fit <- tryCatch(
        survival::survreg(survival::Surv(y, df$event) ~ 1, dist = "gaussian"),
        error = function(e) NULL
      )
      if (is.null(fit)) {
        return(tibble::tibble(
          MedianVolume = NA_real_,
          observed_n = observed_n,
          censored_n = censored_n
        ))
      }
      med <- exp(stats::coef(fit)[1]) - offset
    } else {
      y <- log(x)
      fit <- tryCatch(
        survival::survreg(survival::Surv(y, df$event) ~ 1, dist = "gaussian"),
        error = function(e) NULL
      )
      if (is.null(fit)) {
        return(tibble::tibble(
          MedianVolume = NA_real_,
          observed_n = observed_n,
          censored_n = censored_n
        ))
      }
      med <- exp(stats::coef(fit)[1])
    }
    tibble::tibble(
      MedianVolume = unname(med),
      observed_n = observed_n,
      censored_n = censored_n
    )
  }
  get_nonparametric_volume_summary <- function(df) {
    observed_n <- sum(df$event == 1, na.rm = TRUE)
    censored_n <- sum(df$event == 0, na.rm = TRUE)
    if (observed_n < 1) {
      return(tibble::tibble(
        MedianVolume = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }
    fit <- tryCatch(
      survival::survfit(survival::Surv(df$volume, df$event) ~ 1),
      error = function(e) NULL
    )
    if (is.null(fit)) {
      return(tibble::tibble(
        MedianVolume = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }
    med <- unname(summary(fit)$table["median"])
    tibble::tibble(
      MedianVolume = med,
      observed_n = observed_n,
      censored_n = censored_n
    )
  }
  if (par) {
    summary_data_volume <- analysis_data |>
      dplyr::group_by(.data[[time]], .data[[group]]) |>
      dplyr::group_modify(~ get_parametric_volume_summary(.x)) |>
      dplyr::ungroup()
    plot_title <- if (fold) {
      "Fold Change over Time (Parametric Method)"
    } else {
      "Volume over Time (Parametric Method)"
    }
  } else {
    summary_data_volume <- analysis_data |>
      dplyr::group_by(.data[[time]], .data[[group]]) |>
      dplyr::group_modify(~ get_nonparametric_volume_summary(.x)) |>
      dplyr::ungroup()
    plot_title <- if (fold) {
      "Fold Change over Time (Nonparametric Method)"
    } else {
      "Volume over Time (Nonparametric Method)"
    }
  }
  summary_data_volume <- summary_data_volume |>
    dplyr::left_join(group_size, by = group) |>
    dplyr::arrange(.data[[group]], .data[[time]]) |>
    dplyr::group_by(.data[[group]]) |>
    dplyr::mutate(
      stop_curve = (censored_n / group_n) >= 0.6,
      stop_after = cumsum(stop_curve) > 0,
      MedianVolume = dplyr::if_else(stop_after, NA_real_, MedianVolume)
    ) |>
    dplyr::ungroup()
  if (fold) {
    baseline_time <- min(summary_data_volume[[time]], na.rm = TRUE)
    baseline_data <- summary_data_volume |>
      dplyr::filter(.data[[time]] == baseline_time) |>
      dplyr::select(dplyr::all_of(group), baseline_median = MedianVolume)
    summary_data <- summary_data_volume |>
      dplyr::left_join(baseline_data, by = group) |>
      dplyr::mutate(
        MedianValue = MedianVolume / baseline_median
      ) |>
      dplyr::select(
        dplyr::all_of(time),
        dplyr::all_of(group),
        MedianValue,
        observed_n,
        censored_n,
        group_n,
        stop_curve,
        stop_after
      )
  } else {
    summary_data <- summary_data_volume |>
      dplyr::mutate(MedianValue = MedianVolume) |>
      dplyr::select(
        dplyr::all_of(time),
        dplyr::all_of(group),
        MedianValue,
        observed_n,
        censored_n,
        group_n,
        stop_curve,
        stop_after
      )
  }
  if (fold) {
    data_ind <- analysis_data |>
      dplyr::filter(event == 1, !is.na(fold_change))

    y_ind <- "fold_change"
    y_lab <- "Fold Change"
  } else {
    data_ind <- analysis_data |>
      dplyr::filter(event == 1, !is.na(volume))

    y_ind <- "volume"
    y_lab <- "Volume"
  }
  data_sum <- summary_data |>
    dplyr::filter(!is.na(MedianValue))
  ggplot2::ggplot() +
    ggplot2::geom_line(
      data = data_ind,
      ggplot2::aes(
        x = .data[[time]],
        y = .data[[y_ind]],
        group = .data[[id]],
        color = .data[[group]]
      ),
      alpha = 0.5
    ) +
    ggplot2::geom_line(
      data = data_sum,
      ggplot2::aes(
        x = .data[[time]],
        y = .data[["MedianValue"]],
        color = .data[[group]]
      ),
      linewidth = 1.2
    ) +
    ggplot2::labs(
      x = time,
      y = y_lab,
      title = plot_title,
      color = group
    )
}