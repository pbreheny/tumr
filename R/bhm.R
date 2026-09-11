#' Bayesian Hierarchical Linear Model for Tumor Growth Data
#'
#' @param tumr_obj A \code{tumr} object created by \code{\link{tumr}}.
#' @param data A data frame of tumor growth measurements.
#' @param id Column name of subject IDs.
#' @param time Column name of repeated time measurements.
#' @param measure Column name of repeated tumor measurements.
#' @param group Column name of treatment group assignments.
#' @param cens Optional numeric scalar. If provided, observations with
#'   \code{log1p(measure) <= cens} are treated as left-censored at
#'   \code{cens}. Set \code{cens = NULL} (default) to fit the
#'   non-censored model.
#' @param diagnostics Logical; whether to return diagnostic summaries.
#' @param return_fit Logical; whether to return the CmdStan fit object.
#' @param ... Further arguments passed to the CmdStan sampling method.
#'
#' @return An object of class \code{"bhm"} containing posterior summaries
#'   and optionally diagnostics and the CmdStan fit.
#'
#' @examples
#' \dontrun{
#' data(melanoma2)
#' melanoma2$months <- melanoma2$Day / (365/12)
#' mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
#' fit <- bhm(mel2)
#' fit_cens <- bhm(mel2, cens = log1p(10))
#' }
#'
#' @export

bhm <- function(tumr_obj = NULL,
                data = NULL,
                id = NULL,
                time = NULL,
                measure = NULL,
                group = NULL,
                cens = NULL,
                diagnostics = FALSE,
                return_fit = TRUE,
                ...) {

  if (!requireNamespace("instantiate", quietly = TRUE)) {
    stop(
      "Package 'instantiate' is required for bhm(). Please install it from CRAN.",
      call. = FALSE
    )
  }
  if (!instantiate::stan_cmdstan_exists()) {
    stop(
      "CmdStan is not available.\n",
      "Please install cmdstanr and CmdStan first:\n",
      "install.packages('cmdstanr', repos = c(",
      "'https://mc-stan.org/r-packages/', getOption('repos')))\n",
      "cmdstanr::install_cmdstan()",
      call. = FALSE
    )
  }
  # Extract information from tumr object
  if (!is.null(tumr_obj)) {
    if (is.null(id)) id <- tumr_obj$id
    if (is.null(time)) time <- tumr_obj$time
    if (is.null(measure)) measure <- tumr_obj$measure
    if (is.null(group)) group <- tumr_obj$group
    if (is.null(data)) data <- tumr_obj$data
  }
  # Check required information
  if (is.null(data) ||
      is.null(id) ||
      is.null(time) ||
      is.null(measure) ||
      is.null(group)) {
    stop(
      "Please provide a tumr object, or specify data, id, time, measure, and group.",
      call. = FALSE
    )
  }
  # Standardize variable names internally
  data[[".id"]] <- base::as.factor(data[[id]])
  data[[".time"]] <- data[[time]]
  data[[".measure"]] <- data[[measure]]
  data[[".group"]] <- base::as.factor(data[[group]])
  # Order observations by subject and time
  data <- data[
    order(data[[".id"]], data[[".time"]]),
    ,
    drop = FALSE
  ]
  # Subject IDs
  id_levels <- levels(data[[".id"]])
  id_index <- as.integer(data[[".id"]])
  N_subj <- length(id_levels)
  N <- nrow(data)
  # Outcome and time
  y <- log1p(data[[".measure"]])
  t <- data[[".time"]]
  # Handle censoring
  if (!is.null(cens)) {
    is_cens <- as.integer(y <= cens)
    y_stan <- y
    y_stan[is_cens == 1L] <- cens
  } else {
    is_cens <- NULL
    y_stan <- y
  }
  # Make sure each subject belongs to exactly one treatment group
  trt_check <- tapply(
    data[[".group"]],
    id_index,
    function(x) length(unique(x))
  )
  if (any(trt_check != 1)) {
    stop(
      "Each subject must have exactly one treatment.",
      call. = FALSE
    )
  }
  # Subject-level treatment assignment
  id_first <- !duplicated(id_index)
  trt_by_id <- droplevels(data[[".group"]][id_first])
  trt_levels <- levels(trt_by_id)
  trt_subj <- as.integer(trt_by_id)
  K <- length(trt_levels)
  # Stan data
  stan_data <- list(
    N = N,
    N_subj = N_subj,
    K = K,
    id = as.integer(id_index),
    trt_subj = as.integer(trt_subj),
    y = as.vector(y_stan),
    t = as.vector(t)
  )
  if (!is.null(cens)) {
    stan_data$C <- as.numeric(cens)
    stan_data$is_cens <- as.integer(is_cens)
  }
  # Choose Stan model
  stan_name <- if (is.null(cens)) {
    "bhm"
  } else {
    "bhm_cens"
  }
  model <- instantiate::stan_package_model(
    name = stan_name,
    package = "tumr"
  )
  # Fit model
  fit <- model$sample(
    data = stan_data,
    chains = 4,
    parallel_chains = 4,
    iter_warmup = 1500,
    iter_sampling = 2500,
    seed = 2025,
    ...
  )
  # Posterior summaries
  sum_tbl <- fit$summary()
  parse_1index <- function(x, prefix) {
    as.integer(
      sub(
        paste0("^", prefix, "\\[([0-9]+)\\].*$"),
        "\\1",
        x
      )
    )
  }
  parse_2index <- function(x, prefix) {
    m <- regexec(
      paste0(
        "^",
        prefix,
        "\\[([0-9]+),([0-9]+)\\].*$"
      ),
      x
    )
    r <- regmatches(x, m)[[1]]
    if (length(r) != 3) {
      return(c(NA_integer_, NA_integer_))
    }
    c(
      as.integer(r[2]),
      as.integer(r[3])
    )
  }
  # Treatment-specific slopes
  slope_each <- dplyr::filter(
    sum_tbl,
    grepl("^Slope\\[", .data$variable)
  )
  if (nrow(slope_each) > 0) {
    k <- parse_1index(
      slope_each$variable,
      "Slope"
    )
    slope_each <- dplyr::mutate(
      slope_each,
      k = k,
      treatment = trt_levels[k]
    )
    slope_each <- dplyr::select(
      slope_each,
      .data$treatment,
      .data$mean,
      .data$q5,
      .data$q95,
      .data$rhat,
      .data$ess_bulk,
      .data$ess_tail
    )
    slope_each <- dplyr::arrange(
      slope_each,
      .data$treatment
    )
  }
  # Treatment-specific intercepts
  int_each <- dplyr::filter(sum_tbl, grepl("^Int\\[", .data$variable))
  if (nrow(int_each) > 0) {
    k <- parse_1index(
      int_each$variable,
      "Int"
    )
    int_each <- dplyr::mutate(
      int_each,
      k = k,
      treatment = trt_levels[k]
    )
    int_each <- dplyr::select(
      int_each,
      .data$treatment,
      .data$mean,
      .data$q5,
      .data$q95,
      .data$rhat,
      .data$ess_bulk,
      .data$ess_tail
    )
    int_each <- dplyr::arrange(
      int_each,
      .data$treatment
    )
  }
  # Pairwise slope differences
  slope_diff <- dplyr::filter(
    sum_tbl,
    grepl("^SlopeDiff\\[", .data$variable)
  )
  if (nrow(slope_diff) > 0) {
    ij <- t(
      vapply(
        slope_diff$variable,
        parse_2index,
        integer(2),
        prefix = "SlopeDiff"
      )
    )
    slope_diff$i <- ij[, 1]
    slope_diff$j <- ij[, 2]
    slope_diff <- dplyr::filter(
      slope_diff,
      !is.na(.data$i),
      !is.na(.data$j),
      .data$i < .data$j
    )
    slope_diff <- dplyr::mutate(
      slope_diff,
      trt_i = trt_levels[.data$i],
      trt_j = trt_levels[.data$j],
      contrast = paste0(
        .data$trt_i,
        " - ",
        .data$trt_j
      )
    )
    slope_diff <- dplyr::select(
      slope_diff,
      .data$contrast,
      .data$mean,
      .data$q5,
      .data$q95,
      .data$rhat,
      .data$ess_bulk,
      .data$ess_tail
    )
    slope_diff <- dplyr::arrange(
      slope_diff,
      .data$contrast
    )
  }
  # Output
  out <- list(
    slope_each = slope_each,
    slope_diff = slope_diff,
    int_each = int_each,
    data = data,
    K = K,
    t_range = range(t),
    trt_levels = trt_levels,
    relevant_info = list(
      ID = id,
      Time = time,
      Measure = measure,
      Group = group
    )
  )
  if (isTRUE(diagnostics)) {
    out$diagnostics <- fit$diagnostic_summary()
  }
  if (isTRUE(return_fit)) {
    out$fit <- fit
  }
  class(out) <- "bhm"
  out
}
