#' Process data to be used in plot_median
#'
#' @param time vector of time measurements
#' @param measure vector of tumor growth measurements
#'
#' @return A list with cleaned measurements and event indicators

process_data <- function(time, measure) {
  if (length(time) != length(measure)) stop("time and measure must have the same length.")
  if (all(is.na(measure))) stop("Must have at least one non-missing value.")

  na_indices <- which(is.na(measure))
  measure_clean <- measure
  observed_indices <- which(!is.na(measure))
  first_val_index <- min(observed_indices)
  last_val_index <- max(observed_indices)

  # Interpolate embedded missing values only
  if (length(na_indices) > 0) {
    if (length(observed_indices) >= 2) {
      interp_fun <- stats::approxfun(
        x = time[!is.na(measure)],
        y = measure[!is.na(measure)],
        rule = 1
      )
      for (i in na_indices) {
        if (i > first_val_index && i <= last_val_index) measure_clean[i] <- interp_fun(time[i])
      }
    }

    # Carry forward trailing missing values
    if (last_val_index < length(measure)) {
      measure_clean[(last_val_index + 1):length(measure)] <- measure[last_val_index]
    }
  }

  # event = 1 means observed or interpolated;
  # event = 0 means trailing carried-forward value
  missing_vector <- rep(1, length(measure))
  if (last_val_index < length(measure)) {
    missing_vector[(last_val_index + 1):length(measure)] <- 0
  }

  list(data_no_missing_values = measure_clean, missing_vector = missing_vector)
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
#' @param lld Optional lower limit of detection used to replace zero values.
#'   If NULL, the one half of the minimum nonzero value in the full dataset is used.
#'
#' @return A ggplot object

plot_median <- function(tumr_obj = NULL, data = NULL, group = NULL, time = NULL,
                        measure = NULL, id = NULL, par = TRUE, fold = FALSE, lld = NULL) {

  if (!is.null(tumr_obj)) {
    if (is.null(id)) id <- tumr_obj$id
    if (is.null(time)) time <- tumr_obj$time
    if (is.null(measure)) measure <- tumr_obj$measure
    if (is.null(group)) group <- tumr_obj$group
    if (is.null(data)) data <- tumr_obj$data
  }

  if (is.null(data) || is.null(group) || is.null(time) || is.null(measure) || is.null(id)) {
    stop("Please provide data, group, time, measure, and id, or supply tumr_obj.")
  }

  # Complete missing time points within each subject
  data <- data |>
    tidyr::complete(!!rlang::sym(id), !!rlang::sym(time)) |>
    dplyr::group_by(.data[[id]]) |>
    dplyr::arrange(.data[[time]], .by_group = TRUE) |>
    tidyr::fill(!!rlang::sym(group), .direction = "downup") |>
    dplyr::ungroup()

  # Replace zero measurements by the global lower limit of detection or set by users
  if (any(data[[measure]] == 0, na.rm = TRUE)) {
    if (!is.null(lld)) {
      lld_used <- lld
    } else {
      min_nonzero <- min(data[[measure]][data[[measure]] > 0], na.rm = TRUE)
      lld_used <- min_nonzero / 2
    }
    data[[measure]][!is.na(data[[measure]]) & data[[measure]] == 0] <- lld_used
  }

  # Process missing values subject by subject
  processed_data <- data |>
    dplyr::group_by(.data[[id]]) |>
    dplyr::group_modify(~ {
      .x <- .x |> dplyr::arrange(.data[[time]])
      processed <- process_data(.x[[time]], .x[[measure]])
      tibble::tibble(
        !!group := .x[[group]],
        !!time := .x[[time]],
        volume = processed$data_no_missing_values,
        event = processed$missing_vector
      )
    }) |>
    dplyr::ungroup()

  # Compute fold change within each subject
  compute_fold_data <- function(df, time_var) {
    df <- df |> dplyr::arrange(.data[[time_var]])
    baseline <- df$volume[1]

    if (is.na(baseline)) {
      idx <- which(!is.na(df$volume))[1]
      baseline <- if (!is.na(idx)) df$volume[idx] else NA_real_
    }

    if (is.na(baseline) || baseline <= 0) {
      df$baseline <- baseline
      df$fold_change <- NA_real_
      return(df)
    }

    df$baseline <- baseline
    df$fold_change <- df$volume / baseline
    df
  }

  analysis_data <- processed_data |>
    dplyr::group_by(.data[[id]]) |>
    dplyr::group_modify(~ compute_fold_data(.x, time_var = time)) |>
    dplyr::ungroup()

  group_size <- analysis_data |>
    dplyr::distinct(.data[[group]], .data[[id]]) |>
    dplyr::count(.data[[group]], name = "group_n")

  # Parametric median
  get_parametric_summary <- function(df, value_col) {
    x <- df[[value_col]]
    event <- df$event
    ok <- !is.na(x)
    x <- x[ok]
    event <- event[ok]

    observed_n <- sum(event == 1)
    censored_n <- sum(event == 0)

    if (length(x) == 0 || any(x <= 0)) {
      return(tibble::tibble(
        MedianValue = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }

    y <- log(x)
    fit <- tryCatch(
      survival::survreg(survival::Surv(y, event) ~ 1, dist = "gaussian"),
      warning = function(w) NULL,
      error = function(e) NULL
    )

    if (is.null(fit)) {
      return(tibble::tibble(
        MedianValue = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }

    med <- exp(stats::coef(fit)[1])
    tibble::tibble(MedianValue = unname(med), observed_n = observed_n, censored_n = censored_n)
  }

  # Nonparametric median
  get_nonparametric_summary <- function(df, value_col) {
    x <- df[[value_col]]
    event <- df$event
    ok <- !is.na(x)
    x <- x[ok]
    event <- event[ok]

    observed_n <- sum(event == 1)
    censored_n <- sum(event == 0)

    if (length(x) == 0) {
      return(tibble::tibble(
        MedianValue = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }

    fit <- tryCatch(
      survival::survfit(survival::Surv(x, event) ~ 1),
      error = function(e) NULL
    )

    if (is.null(fit)) {
      return(tibble::tibble(
        MedianValue = NA_real_,
        observed_n = observed_n,
        censored_n = censored_n
      ))
    }

    med <- unname(summary(fit)$table["median"])
    tibble::tibble(MedianValue = med, observed_n = observed_n, censored_n = censored_n)
  }

  value_col <- if (fold) "fold_change" else "volume"

  if (par) {
    summary_data <- analysis_data |>
      dplyr::group_by(.data[[time]], .data[[group]]) |>
      dplyr::group_modify(~ get_parametric_summary(.x, value_col = value_col)) |>
      dplyr::ungroup()

    plot_title <- if (fold) {
      "Fold Change over Time (Parametric Method)"
    } else {
      "Volume over Time (Parametric Method)"
    }
  } else {
    summary_data <- analysis_data |>
      dplyr::group_by(.data[[time]], .data[[group]]) |>
      dplyr::group_modify(~ get_nonparametric_summary(.x, value_col = value_col)) |>
      dplyr::ungroup()

    plot_title <- if (fold) {
      "Fold Change over Time (Nonparametric Method)"
    } else {
      "Volume over Time (Nonparametric Method)"
    }
  }

  # Stop median curve once at least 60% are censored
  summary_data <- summary_data |>
    dplyr::left_join(group_size, by = group) |>
    dplyr::arrange(.data[[group]], .data[[time]]) |>
    dplyr::group_by(.data[[group]]) |>
    dplyr::mutate(
      stop_curve = (censored_n / group_n) >= 0.6,
      stop_after = cumsum(stop_curve) > 0,
      MedianValue = dplyr::if_else(stop_after, NA_real_, MedianValue)
    ) |>
    dplyr::ungroup()

  if (fold) {
    data_ind <- analysis_data |>
      dplyr::filter(event == 1, !is.na(fold_change), is.finite(fold_change))
    y_ind <- "fold_change"
    y_lab <- "Fold Change"
  } else {
    data_ind <- analysis_data |>
      dplyr::filter(event == 1, !is.na(volume), is.finite(volume))
    y_ind <- "volume"
    y_lab <- "Volume"
  }

  data_sum <- summary_data |>
    dplyr::filter(!is.na(MedianValue), is.finite(MedianValue))

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
    ggplot2::labs(x = time, y = y_lab, title = plot_title, color = group) +
    ggplot2::theme_bw() +
    ggplot2::theme(panel.border = ggplot2::element_blank())
}


#' Plot a tumr object
#'
#' @param x A tumr object created by \code{tumr()}.
#' @param ... Additional arguments passed to \code{plot_median()}.
#'
#' @return A ggplot object.
#'
#' @examples
#' data(melanoma2)
#' melanoma2$months <- melanoma2$Day / (365 / 12)
#' mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
#' plot(mel2)
#' plot(mel2, par = FALSE)
#' plot(mel2, fold = TRUE)
#' plot(mel2, par = FALSE, fold = TRUE)
#'
#' @export

plot.tumr <- function(x, ...) {
  plot_median(tumr_obj = x, ...)
}