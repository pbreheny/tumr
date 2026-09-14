# Tumor Doubling Time Based on Fitted Tumor Growth Model

Tumor Doubling Time Based on Fitted Tumor Growth Model

## Usage

``` r
dtime(x)
```

## Arguments

- x:

  A fitted model object.

## Value

A list with three components:

- `method`: character string describing the method used.

- `message`: character string indicating that the model should
  demonstrate an exponential growth pattern.

- `summary`: a data frame summarizing tumor doubling time by treatment
  group, including mean, median, and 95\\

## Examples

``` r
data(melanoma2)
melanoma2$months <- melanoma2$Day / (365/12)
mel2 <- tumr(melanoma2, ID, months, Volume, Treatment)
fit_bhm <- bhm(mel2)
#> Running MCMC with 4 parallel chains...
#> 
#> Chain 1 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 2 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 3 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 4 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpCxBFLs/model-1c3539c1d543.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 2 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 1 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 3 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 4 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 2 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 1 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 3 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 4 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 2 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 1 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 3 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 4 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 2 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 1 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 3 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 4 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 2 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 1 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 3 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 4 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 2 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 1 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 2 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 3 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 4 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 1 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 2 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 3 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 1 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 4 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 2 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 1 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 3 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 4 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 2 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 1 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 3 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 4 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 2 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 1 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 3 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 4 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 2 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 1 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 3 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 4 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 1 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 2 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 3 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 4 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 1 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 2 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 3 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 4 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 1 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 1 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 2 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 2 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 3 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 4 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 1 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 2 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 3 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 3 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 4 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 4 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 1 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 2 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 3 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 4 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 1 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 2 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 3 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 4 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 1 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 2 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 3 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 4 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 1 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 2 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 3 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 4 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 1 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 2 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 3 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 4 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 1 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 2 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 3 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 4 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 1 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 2 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 3 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 4 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 1 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 2 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 3 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 4 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 1 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 2 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 3 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 4 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 2 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 1 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 3 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 4 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 2 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 1 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 3 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 4 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 2 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 1 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 3 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 4 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 2 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 1 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 3 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 4 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 2 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 1 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 4 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 3 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 2 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 1 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 4 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 3 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 2 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 1 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 4 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 3 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 2 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 1 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 4 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 3 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 2 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 1 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 4 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 3 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 2 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 1 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 4 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 3 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 2 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 1 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 4 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 3 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 2 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 1 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 4 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 3 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 2 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 1 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 3 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 4 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 2 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 1 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 3 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 4 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 2 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 2 finished in 36.7 seconds.
#> Chain 1 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 1 finished in 37.0 seconds.
#> Chain 3 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 4 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 3 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 3 finished in 37.6 seconds.
#> Chain 4 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 4 finished in 37.6 seconds.
#> 
#> All 4 chains finished successfully.
#> Mean chain execution time: 37.2 seconds.
#> Total execution time: 37.9 seconds.
#> 
dtime(fit_bhm)
#> $method
#> [1] "Tumor Doubling Time Based on Bayesian hierarchical Model"
#> 
#> $message
#> [1] "The model should demonstrate an exponential growth pattern."
#> 
#> $summary
#> # A tibble: 5 × 5
#>   treatment  mean median  q2.5 q97.5
#>   <chr>     <dbl>  <dbl> <dbl> <dbl>
#> 1 A         0.289  0.285 0.231 0.366
#> 2 B         0.609  0.572 0.391 1.03 
#> 3 C         0.442  0.428 0.322 0.641
#> 4 D         0.429  0.415 0.306 0.644
#> 5 E         0.487  0.468 0.336 0.746
#> 
fit_lmm <- lmm(mel2)
dtime(fit_lmm)
#> $method
#> [1] "Tumor Doubling Time Based on Linear Mixed Model"
#> 
#> $message
#> [1] "The model should demonstrate an exponential growth pattern."
#> 
#> $summary
#>   Treatment mean median q2.5 q97.5
#> 1         A 0.29   0.29 0.23  0.37
#> 2         B 0.60   0.57 0.39  1.00
#> 3         C 0.44   0.43 0.32  0.64
#> 4         D 0.43   0.41 0.31  0.62
#> 5         E 0.49   0.47 0.34  0.73
#> 
```
