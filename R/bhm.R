#' Bayesian hierarchical model for tumor growth
#'
#' @param data data.frame with columns ID, Day, Volume, Treatment
#' @param diagnostics logical; whether to return diagnostic summary
#' @param return_fit logical; whether to return the CmdStan fit object
#' @param ... further arguments passed to CmdStanR $sample()
#'
#' @return A list of posterior summaries (and optionally diagnostics / fit)
#'
#' @examples
#' data(melanoma2)
#' fit <- bhm(melanoma2)
#' fit
#'
#' @export


bhm <- function(data, diagnostics = FALSE, return_fit = TRUE, ...) {

  if (!requireNamespace("instantiate", quietly = TRUE)) {
    stop("Package 'instantiate' is required for bhm(). Please install it from CRAN.", call. = FALSE)
  }
  if (!instantiate::stan_cmdstan_exists()) {
    stop(
      "CmdStan is not available.\n",
      "Please install cmdstanr and CmdStan first:\n",
      "install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos')))\n",
      "cmdstanr::install_cmdstan()",
      call. = FALSE
    )
  }

  stopifnot(
    is.data.frame(data),
    all(c("ID", "Day", "Volume", "Treatment") %in% names(data))
  )

  data <- data[order(data$ID, data$Day), , drop = FALSE]

  id_levels <- sort(unique(data$ID))
  id <- match(data$ID, id_levels)
  N_subj <- length(id_levels)
  N <- nrow(data)

  y <- log(data$Volume)
  y[is.infinite(y)] <- log(0.1)
  t <- data$Day

  data$Treatment <- factor(data$Treatment)

  id_first <- !duplicated(id)
  trt_by_id <- data$Treatment[id_first]

  if (any(tapply(data$Treatment, id, function(x) length(unique(x))) != 1)) {
    stop("Each subject must have exactly one treatment.", call. = FALSE)
  }

  trt_levels <- levels(trt_by_id)
  trt_subj <- as.integer(trt_by_id)
  K <- length(trt_levels)

  stan_data <- list(
    N = N,
    N_subj = N_subj,
    K = K,
    id = as.integer(id),
    trt_subj = as.integer(trt_subj),
    y = as.vector(y),
    t = as.vector(t)
  )

  model <- instantiate::stan_package_model(name = "bhm", package = "tumr")

  fit <- model$sample(
    data = stan_data,
    chains = 4,
    parallel_chains = 4,
    iter_warmup = 1500,
    iter_sampling = 2500,
    seed = 2025,
    ...
  )

  sum_tbl <- fit$summary()

  parse_1index <- function(x, prefix) {
    as.integer(sub(paste0("^", prefix, "\\[([0-9]+)\\].*$"), "\\1", x))
  }
  parse_2index <- function(x, prefix) {
    m <- regexec(paste0("^", prefix, "\\[([0-9]+),([0-9]+)\\].*$"), x)
    r <- regmatches(x, m)[[1]]
    if (length(r) != 3) return(c(NA_integer_, NA_integer_))
    c(as.integer(r[2]), as.integer(r[3]))
  }

  slope_each <- dplyr::filter(sum_tbl, grepl("^Slope\\[", .data$variable))
  if (nrow(slope_each) > 0) {
    k <- parse_1index(slope_each$variable, "Slope")
    slope_each <- dplyr::mutate(slope_each, k = k, treatment = trt_levels[k])
    slope_each <- dplyr::select(slope_each, .data$treatment, .data$mean, .data$q5, .data$q95,
                                .data$rhat, .data$ess_bulk, .data$ess_tail)
    slope_each <- dplyr::arrange(slope_each, .data$treatment)
  }

  int_each <- dplyr::filter(sum_tbl, grepl("^Int\\[", .data$variable))
  if (nrow(int_each) > 0) {
    k <- parse_1index(int_each$variable, "Int")
    int_each <- dplyr::mutate(int_each, k = k, treatment = trt_levels[k])
    int_each <- dplyr::select(int_each, .data$treatment, .data$mean, .data$q5, .data$q95,
                              .data$rhat, .data$ess_bulk, .data$ess_tail)
    int_each <- dplyr::arrange(int_each, .data$treatment)
  }

  slope_diff <- dplyr::filter(sum_tbl, grepl("^SlopeDiff\\[", .data$variable))
  if (nrow(slope_diff) > 0) {
    ij <- t(vapply(slope_diff$variable, parse_2index, integer(2), prefix = "SlopeDiff"))
    slope_diff$i <- ij[, 1]
    slope_diff$j <- ij[, 2]
    slope_diff <- dplyr::filter(slope_diff, !is.na(.data$i), !is.na(.data$j), .data$i < .data$j)
    slope_diff <- dplyr::mutate(
      slope_diff,
      trt_i = trt_levels[.data$i],
      trt_j = trt_levels[.data$j],
      contrast = paste0(.data$trt_i, " - ", .data$trt_j)
    )
    slope_diff <- dplyr::select(slope_diff, .data$contrast, .data$mean, .data$q5, .data$q95,
                                .data$rhat, .data$ess_bulk, .data$ess_tail)
    slope_diff <- dplyr::arrange(slope_diff, .data$contrast)
  }

  out <- list(
    slope_each = slope_each,
    slope_diff = slope_diff,
    int_each = int_each
  )

  if (isTRUE(diagnostics)) {
    out$diagnostics <- fit$diagnostic_summary()
  }
  if (isTRUE(return_fit)) {
    out$fit <- fit
  }

  out
}
