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
mel2 <- tumr(melanoma2, ID, Day, Volume, Treatment)
fit1 <- bhm(melanoma2)
#> Running MCMC with 4 parallel chains...
#> 
#> Chain 1 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 1 
#> Chain 2 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 2 
#> Chain 3 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 3 
#> Chain 4 Iteration:    1 / 4000 [  0%]  (Warmup) 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:
#> Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpflSbmk/model-20c63b4e1e91.stan', line 52, column 2 to column 32)
#> Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,
#> Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.
#> Chain 4 
#> Chain 1 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 3 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 2 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 4 Iteration:  100 / 4000 [  2%]  (Warmup) 
#> Chain 1 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 3 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 2 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 4 Iteration:  200 / 4000 [  5%]  (Warmup) 
#> Chain 1 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 3 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 2 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 1 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 4 Iteration:  300 / 4000 [  7%]  (Warmup) 
#> Chain 3 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 2 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 1 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 4 Iteration:  400 / 4000 [ 10%]  (Warmup) 
#> Chain 3 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 2 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 1 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 4 Iteration:  500 / 4000 [ 12%]  (Warmup) 
#> Chain 2 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 3 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 1 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 4 Iteration:  600 / 4000 [ 15%]  (Warmup) 
#> Chain 2 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 3 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 1 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 4 Iteration:  700 / 4000 [ 17%]  (Warmup) 
#> Chain 2 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 3 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 1 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 4 Iteration:  800 / 4000 [ 20%]  (Warmup) 
#> Chain 3 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 2 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 1 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 4 Iteration:  900 / 4000 [ 22%]  (Warmup) 
#> Chain 2 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 3 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 1 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 4 Iteration: 1000 / 4000 [ 25%]  (Warmup) 
#> Chain 2 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 3 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 1 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 4 Iteration: 1100 / 4000 [ 27%]  (Warmup) 
#> Chain 3 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 2 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 4 Iteration: 1200 / 4000 [ 30%]  (Warmup) 
#> Chain 1 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 2 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 3 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 1 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 2 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 4 Iteration: 1300 / 4000 [ 32%]  (Warmup) 
#> Chain 3 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 4 Iteration: 1400 / 4000 [ 35%]  (Warmup) 
#> Chain 1 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 1 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 3 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 3 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 2 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 2 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 1 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 4 Iteration: 1500 / 4000 [ 37%]  (Warmup) 
#> Chain 4 Iteration: 1501 / 4000 [ 37%]  (Sampling) 
#> Chain 3 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 2 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 1 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 3 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 4 Iteration: 1600 / 4000 [ 40%]  (Sampling) 
#> Chain 1 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 2 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 3 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 4 Iteration: 1700 / 4000 [ 42%]  (Sampling) 
#> Chain 1 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 3 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 2 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 4 Iteration: 1800 / 4000 [ 45%]  (Sampling) 
#> Chain 1 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 3 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 4 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 2 Iteration: 1900 / 4000 [ 47%]  (Sampling) 
#> Chain 1 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 3 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 4 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 1 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 2 Iteration: 2000 / 4000 [ 50%]  (Sampling) 
#> Chain 3 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 4 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 1 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 2 Iteration: 2100 / 4000 [ 52%]  (Sampling) 
#> Chain 3 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 4 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 1 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 3 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 2 Iteration: 2200 / 4000 [ 55%]  (Sampling) 
#> Chain 1 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 4 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 3 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 1 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 2 Iteration: 2300 / 4000 [ 57%]  (Sampling) 
#> Chain 4 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 3 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 1 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 4 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 2 Iteration: 2400 / 4000 [ 60%]  (Sampling) 
#> Chain 3 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 1 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 4 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 3 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 2 Iteration: 2500 / 4000 [ 62%]  (Sampling) 
#> Chain 1 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 3 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 4 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 1 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 2 Iteration: 2600 / 4000 [ 65%]  (Sampling) 
#> Chain 3 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 4 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 1 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 2 Iteration: 2700 / 4000 [ 67%]  (Sampling) 
#> Chain 3 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 4 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 1 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 3 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 2 Iteration: 2800 / 4000 [ 70%]  (Sampling) 
#> Chain 4 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 1 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 3 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 2 Iteration: 2900 / 4000 [ 72%]  (Sampling) 
#> Chain 4 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 1 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 3 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 1 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 4 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 2 Iteration: 3000 / 4000 [ 75%]  (Sampling) 
#> Chain 3 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 1 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 4 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 2 Iteration: 3100 / 4000 [ 77%]  (Sampling) 
#> Chain 3 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 1 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 4 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 3 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 1 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 2 Iteration: 3200 / 4000 [ 80%]  (Sampling) 
#> Chain 4 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 3 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 1 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 2 Iteration: 3300 / 4000 [ 82%]  (Sampling) 
#> Chain 4 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 3 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 1 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 1 finished in 43.2 seconds.
#> Chain 2 Iteration: 3400 / 4000 [ 85%]  (Sampling) 
#> Chain 4 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 3 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 3 finished in 43.7 seconds.
#> Chain 2 Iteration: 3500 / 4000 [ 87%]  (Sampling) 
#> Chain 4 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 2 Iteration: 3600 / 4000 [ 90%]  (Sampling) 
#> Chain 4 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 4 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 4 finished in 45.2 seconds.
#> Chain 2 Iteration: 3700 / 4000 [ 92%]  (Sampling) 
#> Chain 2 Iteration: 3800 / 4000 [ 95%]  (Sampling) 
#> Chain 2 Iteration: 3900 / 4000 [ 97%]  (Sampling) 
#> Chain 2 Iteration: 4000 / 4000 [100%]  (Sampling) 
#> Chain 2 finished in 47.0 seconds.
#> 
#> All 4 chains finished successfully.
#> Mean chain execution time: 44.8 seconds.
#> Total execution time: 47.1 seconds.
#> 
dtime(fit1)
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
#> 1 A          8.78   8.68  7.04  11.1
#> 2 B         18.3   17.2  11.9   31.1
#> 3 C         13.5   13.0   9.74  19.5
#> 4 D         13.1   12.6   9.34  19.5
#> 5 E         14.7   14.1  10.0   22.8
#> 
fit2 <- lmm(mel2)
#> Warning: Model failed to converge with max|grad| = 0.00566844 (tol = 0.002, component 1)
#>   See ?lme4::convergence and ?lme4::troubleshooting.
dtime(fit2)
#> $method
#> [1] "Tumor Doubling Time Based on Linear Mixed Model"
#> 
#> $message
#> [1] "The model should demonstrate an exponential growth pattern."
#> 
#> $summary
#>   Treatment  mean median  q2.5 q97.5
#> 1         A  8.79   8.72  7.14 11.20
#> 2         B 18.38  17.36 11.94 30.46
#> 3         C 13.38  12.98  9.88 19.41
#> 4         D 13.00  12.57  9.32 18.80
#> 5         E 14.78  14.16 10.30 22.35
#> 
```
