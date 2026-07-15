libs <- file.path(R_PACKAGE_DIR, "libs", R_ARCH)
dir.create(libs, recursive = TRUE, showWarnings = FALSE)
for (file in c("symbols.rds", Sys.glob(paste0("*", SHLIB_EXT)))) {
  if (file.exists(file)) {
    file.copy(file, file.path(libs, file))
  }
}
inst_stan <- file.path("..", "inst", "stan")
if (dir.exists(inst_stan)) {
  warning(
    "Stan models in inst/stan/ are deprecated in {instantiate} ",
    ">= 0.0.4.9001 (2024-01-03). Please put them in src/stan/ instead."
  )
  if (file.exists("stan")) {
    warning("src/stan/ already exists. Not copying models from inst/stan/.")
  } else {
    message("Copying inst/stan/ to src/stan/.")
    fs::dir_copy(path = inst_stan, new_path = "stan")
  }
}
bin <- file.path(R_PACKAGE_DIR, "bin")
if (!file.exists(bin)) {
  dir.create(bin, recursive = TRUE, showWarnings = FALSE)
}
bin_stan <- file.path(bin, "stan")
fs::dir_copy(path = "stan", new_path = bin_stan)
callr::r(
  func = function(bin_stan) {
    stan_files <- list.files(bin_stan, pattern = "\\.stan$", full.names = TRUE)
    if (!length(stan_files)) return(invisible(NULL))

    for (f in stan_files) {
      # Eigen's OpenMP-based parallelization conflicts with Stan's TBB threading
      # and fails to link if the installing user has -fopenmp in their CXXFLAGS.
      cmdstanr::cmdstan_model(
        stan_file = f,
        compile = TRUE,
        quiet = TRUE,
        cpp_options = list(CXXFLAGS = "-DEIGEN_DONT_PARALLELIZE")
      )
    }
    invisible(NULL)
  },
  args = list(bin_stan = bin_stan),
  libpath = .libPaths()
)
