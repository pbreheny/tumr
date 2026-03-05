// Bayesian hierarchical linear model with left-censoring
data {
  int<lower=1> N;                      // total observations
  int<lower=1> N_subj;                 // number of subjects
  int<lower=1> K;                      // number of treatment groups

  array[N] int<lower=1, upper=N_subj> id;        // subject index
  array[N_subj] int<lower=1, upper=K> trt_subj;  // subject's treatment group

  vector[N] y;                         // observed y
  vector[N] t;                         // time

  real C;                              // censoring cutoff (set in main function)
  array[N] int<lower=0, upper=1> is_cens;  // indicator function equals 1 if true y <= C
}

parameters {
  vector[K] Int;        // mean intercept for each treatment
  vector[K] Slope;      // mean slope for each treatment

  real<lower=0> sdLevel1;

  vector<lower=0>[2] tau;                 // SDs of random effects
  cholesky_factor_corr[2] L_corr;         // correlation
  array[N_subj] vector[2] z;              // i.i.d. N(0,1)
}

transformed parameters {
  array[N_subj] vector[2] beta;           // subject-specific (int, slope)
  matrix[2,2] L = diag_pre_multiply(tau, L_corr);

  for (i in 1:N_subj) {
    vector[2] mu_i;
    int g = trt_subj[i];

    mu_i[1] = Int[g];
    mu_i[2] = Slope[g];

    beta[i] = mu_i + L * z[i];
  }
}

model {
  // priors
  Int   ~ normal(0, 10);
  Slope ~ normal(0, 10);

  sdLevel1 ~ normal(0, 5);          // half-normal via <lower=0>
  tau      ~ normal(0, 5);          // half-normal via <lower=0>

  L_corr ~ lkj_corr_cholesky(2);
  for (i in 1:N_subj) z[i] ~ normal(0, 1);

  // Likelihood with left censoring
  for (n in 1:N) {
    real mu_n;
    mu_n = beta[id[n]][1] + beta[id[n]][2] * t[n];
    if (is_cens[n] == 0) {
      target += normal_lpdf(y[n] | mu_n, sdLevel1);
    } else {
      target += normal_lcdf(C | mu_n, sdLevel1);
    }
  }
}

generated quantities {
  matrix[K,K] IntDiff;
  matrix[K,K] SlopeDiff;

  for (i in 1:K) {
    for (j in 1:K) {
      IntDiff[i,j] = Int[i] - Int[j];
      SlopeDiff[i,j] = Slope[i] - Slope[j];
    }
  }
}