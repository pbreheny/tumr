# Bayesian Hierarchical Linear Model

## Model setting and notation

Let g = 1,\ldots,K index treatment groups and i =
1,\ldots,N\_{\text{subj}} index subjects.  
Subject i belongs to treatment group g_i \in \\1,\ldots,K\\.  
Let V\_{in} \> 0 denote the observed tumor volume for subject i at time
t\_{in}, and define the log-volume

y\_{in} = \log(V\_{in}).

### Model (log-volume scale)

#### Observation model (Level 1)

For each subject i and measurement n,

y\_{in} \mid \alpha_i, \beta_i, \sigma \sim \mathcal{N}\left(\alpha_i +
\beta_i t\_{in}, \sigma^2\right),

where \alpha_i is the subject-specific intercept (baseline log-volume at
t=0),  
\beta_i is the subject-specific slope (log-scale growth rate),  
and \sigma\>0 is the residual standard deviation.

#### Subject-level random effects (Level 2)

Define the subject-specific parameter vector

\theta_i = \begin{pmatrix} \alpha_i \\ \beta_i \end{pmatrix}, \qquad
\mu_g = \begin{pmatrix} \alpha_g \\ \beta_g \end{pmatrix}.

Conditional on the treatment group g_i,

\theta_i \mid g_i, \mu\_{g_i}, \Sigma \sim \mathcal{N}\_2(\mu\_{g_i},
\Sigma).

We parameterize the random-effects covariance matrix as

\Sigma = D R D, \qquad D = \mathrm{diag}(\tau\_\alpha,\tau\_\beta),
\qquad R = \begin{pmatrix} 1 & \rho \\ \rho & 1 \end{pmatrix},

where \tau\_\alpha\>0 and \tau\_\beta\>0 are the standard deviations of
the random intercept and random slope, and \rho \in (-1,1) is their
correlation.

#### Priors (Level 3)

For g=1,\ldots,K,

\alpha_g \sim \mathcal{N}(0,10^2), \qquad \beta_g \sim
\mathcal{N}(0,10^2).

Residual standard deviation:

\sigma \sim \text{Half-}\mathcal{N}(0,5^2).

Random-effects standard deviations:

\tau\_\alpha \sim \text{Half-}\mathcal{N}(0,5^2), \qquad \tau\_\beta
\sim \text{Half-}\mathcal{N}(0,5^2).

Correlation matrix prior:

R \sim \mathrm{LKJ}(2).

#### Summary

\begin{aligned} y\_{in} \mid \alpha_i,\beta_i,\sigma &\sim
\mathcal{N}(\alpha_i+\beta_i t\_{in},\sigma^2),\\ \theta_i \mid g_i
&\sim \mathcal{N}\_2(\mu\_{g_i}, D R D),\\ \alpha_g &\sim
\mathcal{N}(0,10^2), \quad \beta_g \sim \mathcal{N}(0,10^2),\\ \sigma
&\sim \text{Half-}\mathcal{N}(0,5^2),\\ \tau\_\alpha,\tau\_\beta &\sim
\text{Half-}\mathcal{N}(0,5^2), \quad R \sim \mathrm{LKJ}(2).
\end{aligned}

## Example

### Model fit

``` r
data(melanoma2)
fit <- bhm(melanoma2)
```

    Running MCMC with 4 parallel chains...

    Chain 1 Iteration:    1 / 4000 [  0%]  (Warmup) 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 1 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 1 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 1 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 1 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 1 

    Chain 2 Iteration:    1 / 4000 [  0%]  (Warmup) 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 2 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 2 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 2 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 2 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 2 

    Chain 3 Iteration:    1 / 4000 [  0%]  (Warmup) 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 3 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 3 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 3 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 3 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 3 

    Chain 4 Iteration:    1 / 4000 [  0%]  (Warmup) 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 4 Informational Message: The current Metropolis proposal is about to be rejected because of the following issue:

    Chain 4 Exception: lkj_corr_cholesky_lpdf: Random variable[2] is 0, but must be positive! (in '/tmp/RtmpNPkZUF/model-208d60dca8aa.stan', line 52, column 2 to column 32)

    Chain 4 If this warning occurs sporadically, such as for highly constrained variable types like covariance matrices, then the sampler is fine,

    Chain 4 but if this warning occurs often then your model may be either severely ill-conditioned or misspecified.

    Chain 4 

    Chain 1 Iteration:  100 / 4000 [  2%]  (Warmup)
    Chain 4 Iteration:  100 / 4000 [  2%]  (Warmup)
    Chain 2 Iteration:  100 / 4000 [  2%]  (Warmup)
    Chain 3 Iteration:  100 / 4000 [  2%]  (Warmup)
    Chain 1 Iteration:  200 / 4000 [  5%]  (Warmup)
    Chain 2 Iteration:  200 / 4000 [  5%]  (Warmup)
    Chain 3 Iteration:  200 / 4000 [  5%]  (Warmup)
    Chain 4 Iteration:  200 / 4000 [  5%]  (Warmup)
    Chain 1 Iteration:  300 / 4000 [  7%]  (Warmup)
    Chain 2 Iteration:  300 / 4000 [  7%]  (Warmup)
    Chain 3 Iteration:  300 / 4000 [  7%]  (Warmup)
    Chain 4 Iteration:  300 / 4000 [  7%]  (Warmup)
    Chain 1 Iteration:  400 / 4000 [ 10%]  (Warmup)
    Chain 2 Iteration:  400 / 4000 [ 10%]  (Warmup)
    Chain 3 Iteration:  400 / 4000 [ 10%]  (Warmup)
    Chain 4 Iteration:  400 / 4000 [ 10%]  (Warmup)
    Chain 1 Iteration:  500 / 4000 [ 12%]  (Warmup)
    Chain 4 Iteration:  500 / 4000 [ 12%]  (Warmup)
    Chain 2 Iteration:  500 / 4000 [ 12%]  (Warmup)
    Chain 3 Iteration:  500 / 4000 [ 12%]  (Warmup)
    Chain 1 Iteration:  600 / 4000 [ 15%]  (Warmup)
    Chain 2 Iteration:  600 / 4000 [ 15%]  (Warmup)
    Chain 4 Iteration:  600 / 4000 [ 15%]  (Warmup)
    Chain 3 Iteration:  600 / 4000 [ 15%]  (Warmup)
    Chain 1 Iteration:  700 / 4000 [ 17%]  (Warmup)
    Chain 2 Iteration:  700 / 4000 [ 17%]  (Warmup)
    Chain 3 Iteration:  700 / 4000 [ 17%]  (Warmup)
    Chain 4 Iteration:  700 / 4000 [ 17%]  (Warmup)
    Chain 1 Iteration:  800 / 4000 [ 20%]  (Warmup)
    Chain 2 Iteration:  800 / 4000 [ 20%]  (Warmup)
    Chain 3 Iteration:  800 / 4000 [ 20%]  (Warmup)
    Chain 4 Iteration:  800 / 4000 [ 20%]  (Warmup)
    Chain 1 Iteration:  900 / 4000 [ 22%]  (Warmup)
    Chain 2 Iteration:  900 / 4000 [ 22%]  (Warmup)
    Chain 3 Iteration:  900 / 4000 [ 22%]  (Warmup)
    Chain 4 Iteration:  900 / 4000 [ 22%]  (Warmup)
    Chain 1 Iteration: 1000 / 4000 [ 25%]  (Warmup)
    Chain 2 Iteration: 1000 / 4000 [ 25%]  (Warmup)
    Chain 3 Iteration: 1000 / 4000 [ 25%]  (Warmup)
    Chain 4 Iteration: 1000 / 4000 [ 25%]  (Warmup)
    Chain 1 Iteration: 1100 / 4000 [ 27%]  (Warmup)
    Chain 2 Iteration: 1100 / 4000 [ 27%]  (Warmup)
    Chain 3 Iteration: 1100 / 4000 [ 27%]  (Warmup)
    Chain 4 Iteration: 1100 / 4000 [ 27%]  (Warmup)
    Chain 1 Iteration: 1200 / 4000 [ 30%]  (Warmup)
    Chain 4 Iteration: 1200 / 4000 [ 30%]  (Warmup)
    Chain 2 Iteration: 1200 / 4000 [ 30%]  (Warmup)
    Chain 3 Iteration: 1200 / 4000 [ 30%]  (Warmup)
    Chain 1 Iteration: 1300 / 4000 [ 32%]  (Warmup)
    Chain 2 Iteration: 1300 / 4000 [ 32%]  (Warmup)
    Chain 3 Iteration: 1300 / 4000 [ 32%]  (Warmup)
    Chain 4 Iteration: 1300 / 4000 [ 32%]  (Warmup)
    Chain 2 Iteration: 1400 / 4000 [ 35%]  (Warmup)
    Chain 1 Iteration: 1400 / 4000 [ 35%]  (Warmup)
    Chain 3 Iteration: 1400 / 4000 [ 35%]  (Warmup)
    Chain 4 Iteration: 1400 / 4000 [ 35%]  (Warmup)
    Chain 1 Iteration: 1500 / 4000 [ 37%]  (Warmup)
    Chain 1 Iteration: 1501 / 4000 [ 37%]  (Sampling)
    Chain 2 Iteration: 1500 / 4000 [ 37%]  (Warmup)
    Chain 2 Iteration: 1501 / 4000 [ 37%]  (Sampling)
    Chain 3 Iteration: 1500 / 4000 [ 37%]  (Warmup)
    Chain 3 Iteration: 1501 / 4000 [ 37%]  (Sampling)
    Chain 4 Iteration: 1500 / 4000 [ 37%]  (Warmup)
    Chain 4 Iteration: 1501 / 4000 [ 37%]  (Sampling)
    Chain 1 Iteration: 1600 / 4000 [ 40%]  (Sampling)
    Chain 3 Iteration: 1600 / 4000 [ 40%]  (Sampling)
    Chain 4 Iteration: 1600 / 4000 [ 40%]  (Sampling)
    Chain 2 Iteration: 1600 / 4000 [ 40%]  (Sampling)
    Chain 1 Iteration: 1700 / 4000 [ 42%]  (Sampling)
    Chain 3 Iteration: 1700 / 4000 [ 42%]  (Sampling)
    Chain 4 Iteration: 1700 / 4000 [ 42%]  (Sampling)
    Chain 2 Iteration: 1700 / 4000 [ 42%]  (Sampling)
    Chain 1 Iteration: 1800 / 4000 [ 45%]  (Sampling)
    Chain 3 Iteration: 1800 / 4000 [ 45%]  (Sampling)
    Chain 4 Iteration: 1800 / 4000 [ 45%]  (Sampling)
    Chain 1 Iteration: 1900 / 4000 [ 47%]  (Sampling)
    Chain 2 Iteration: 1800 / 4000 [ 45%]  (Sampling)
    Chain 3 Iteration: 1900 / 4000 [ 47%]  (Sampling)
    Chain 4 Iteration: 1900 / 4000 [ 47%]  (Sampling)
    Chain 1 Iteration: 2000 / 4000 [ 50%]  (Sampling)
    Chain 3 Iteration: 2000 / 4000 [ 50%]  (Sampling)
    Chain 2 Iteration: 1900 / 4000 [ 47%]  (Sampling)
    Chain 1 Iteration: 2100 / 4000 [ 52%]  (Sampling)
    Chain 4 Iteration: 2000 / 4000 [ 50%]  (Sampling)
    Chain 3 Iteration: 2100 / 4000 [ 52%]  (Sampling)
    Chain 2 Iteration: 2000 / 4000 [ 50%]  (Sampling)
    Chain 1 Iteration: 2200 / 4000 [ 55%]  (Sampling)
    Chain 4 Iteration: 2100 / 4000 [ 52%]  (Sampling)
    Chain 3 Iteration: 2200 / 4000 [ 55%]  (Sampling)
    Chain 1 Iteration: 2300 / 4000 [ 57%]  (Sampling)
    Chain 2 Iteration: 2100 / 4000 [ 52%]  (Sampling)
    Chain 4 Iteration: 2200 / 4000 [ 55%]  (Sampling)
    Chain 3 Iteration: 2300 / 4000 [ 57%]  (Sampling)
    Chain 1 Iteration: 2400 / 4000 [ 60%]  (Sampling)
    Chain 4 Iteration: 2300 / 4000 [ 57%]  (Sampling)
    Chain 2 Iteration: 2200 / 4000 [ 55%]  (Sampling)
    Chain 3 Iteration: 2400 / 4000 [ 60%]  (Sampling)
    Chain 1 Iteration: 2500 / 4000 [ 62%]  (Sampling)
    Chain 4 Iteration: 2400 / 4000 [ 60%]  (Sampling)
    Chain 3 Iteration: 2500 / 4000 [ 62%]  (Sampling)
    Chain 2 Iteration: 2300 / 4000 [ 57%]  (Sampling)
    Chain 1 Iteration: 2600 / 4000 [ 65%]  (Sampling)
    Chain 3 Iteration: 2600 / 4000 [ 65%]  (Sampling)
    Chain 4 Iteration: 2500 / 4000 [ 62%]  (Sampling)
    Chain 1 Iteration: 2700 / 4000 [ 67%]  (Sampling)
    Chain 2 Iteration: 2400 / 4000 [ 60%]  (Sampling)
    Chain 3 Iteration: 2700 / 4000 [ 67%]  (Sampling)
    Chain 4 Iteration: 2600 / 4000 [ 65%]  (Sampling)
    Chain 1 Iteration: 2800 / 4000 [ 70%]  (Sampling)
    Chain 2 Iteration: 2500 / 4000 [ 62%]  (Sampling)
    Chain 3 Iteration: 2800 / 4000 [ 70%]  (Sampling)
    Chain 1 Iteration: 2900 / 4000 [ 72%]  (Sampling)
    Chain 4 Iteration: 2700 / 4000 [ 67%]  (Sampling)
    Chain 3 Iteration: 2900 / 4000 [ 72%]  (Sampling)
    Chain 1 Iteration: 3000 / 4000 [ 75%]  (Sampling)
    Chain 2 Iteration: 2600 / 4000 [ 65%]  (Sampling)
    Chain 4 Iteration: 2800 / 4000 [ 70%]  (Sampling)
    Chain 3 Iteration: 3000 / 4000 [ 75%]  (Sampling)
    Chain 1 Iteration: 3100 / 4000 [ 77%]  (Sampling)
    Chain 2 Iteration: 2700 / 4000 [ 67%]  (Sampling)
    Chain 4 Iteration: 2900 / 4000 [ 72%]  (Sampling)
    Chain 3 Iteration: 3100 / 4000 [ 77%]  (Sampling)
    Chain 1 Iteration: 3200 / 4000 [ 80%]  (Sampling)
    Chain 4 Iteration: 3000 / 4000 [ 75%]  (Sampling)
    Chain 2 Iteration: 2800 / 4000 [ 70%]  (Sampling)
    Chain 3 Iteration: 3200 / 4000 [ 80%]  (Sampling)
    Chain 1 Iteration: 3300 / 4000 [ 82%]  (Sampling)
    Chain 4 Iteration: 3100 / 4000 [ 77%]  (Sampling)
    Chain 2 Iteration: 2900 / 4000 [ 72%]  (Sampling)
    Chain 3 Iteration: 3300 / 4000 [ 82%]  (Sampling)
    Chain 1 Iteration: 3400 / 4000 [ 85%]  (Sampling)
    Chain 4 Iteration: 3200 / 4000 [ 80%]  (Sampling)
    Chain 3 Iteration: 3400 / 4000 [ 85%]  (Sampling)
    Chain 1 Iteration: 3500 / 4000 [ 87%]  (Sampling)
    Chain 2 Iteration: 3000 / 4000 [ 75%]  (Sampling)
    Chain 4 Iteration: 3300 / 4000 [ 82%]  (Sampling)
    Chain 3 Iteration: 3500 / 4000 [ 87%]  (Sampling)
    Chain 1 Iteration: 3600 / 4000 [ 90%]  (Sampling)
    Chain 2 Iteration: 3100 / 4000 [ 77%]  (Sampling)
    Chain 3 Iteration: 3600 / 4000 [ 90%]  (Sampling)
    Chain 4 Iteration: 3400 / 4000 [ 85%]  (Sampling)
    Chain 1 Iteration: 3700 / 4000 [ 92%]  (Sampling)
    Chain 3 Iteration: 3700 / 4000 [ 92%]  (Sampling)
    Chain 4 Iteration: 3500 / 4000 [ 87%]  (Sampling)
    Chain 2 Iteration: 3200 / 4000 [ 80%]  (Sampling)
    Chain 1 Iteration: 3800 / 4000 [ 95%]  (Sampling)
    Chain 3 Iteration: 3800 / 4000 [ 95%]  (Sampling)
    Chain 4 Iteration: 3600 / 4000 [ 90%]  (Sampling)
    Chain 1 Iteration: 3900 / 4000 [ 97%]  (Sampling)
    Chain 2 Iteration: 3300 / 4000 [ 82%]  (Sampling)
    Chain 3 Iteration: 3900 / 4000 [ 97%]  (Sampling)
    Chain 1 Iteration: 4000 / 4000 [100%]  (Sampling)
    Chain 4 Iteration: 3700 / 4000 [ 92%]  (Sampling)
    Chain 1 finished in 43.5 seconds.
    Chain 4 Iteration: 3800 / 4000 [ 95%]  (Sampling)
    Chain 2 Iteration: 3400 / 4000 [ 85%]  (Sampling)
    Chain 3 Iteration: 4000 / 4000 [100%]  (Sampling)
    Chain 3 finished in 44.3 seconds.
    Chain 4 Iteration: 3900 / 4000 [ 97%]  (Sampling)
    Chain 2 Iteration: 3500 / 4000 [ 87%]  (Sampling)
    Chain 4 Iteration: 4000 / 4000 [100%]  (Sampling)
    Chain 4 finished in 45.0 seconds.
    Chain 2 Iteration: 3600 / 4000 [ 90%]  (Sampling)
    Chain 2 Iteration: 3700 / 4000 [ 92%]  (Sampling)
    Chain 2 Iteration: 3800 / 4000 [ 95%]  (Sampling)
    Chain 2 Iteration: 3900 / 4000 [ 97%]  (Sampling)
    Chain 2 Iteration: 4000 / 4000 [100%]  (Sampling)
    Chain 2 finished in 47.6 seconds.

    All 4 chains finished successfully.
    Mean chain execution time: 45.1 seconds.
    Total execution time: 47.8 seconds.

### Summary of the results

``` r
summary(fit)
```

    $int_each
    # A tibble: 5 × 7
      treatment  mean    q5   q95 exp_mean exp_q5 exp_q95
      <chr>     <dbl> <dbl> <dbl>    <dbl>  <dbl>   <dbl>
    1 A          3.65  3.27  4.04     38.5   26.3    56.7
    2 B          4.19  3.81  4.58     66.3   45.0    97.7
    3 C          4.44  4.06  4.81     84.7   58.3   122.
    4 D          4.99  4.61  5.37    147.   101.    216.
    5 E          3.50  3.10  3.92     33.2   22.2    50.5

    $slope_each
    # A tibble: 5 × 10
      treatment   mean     q5    q95 growth_factor_mean growth_factor_q5
      <chr>      <dbl>  <dbl>  <dbl>              <dbl>            <dbl>
    1 A         0.0800 0.0652 0.0956               1.08             1.07
    2 B         0.0403 0.0253 0.0552               1.04             1.03
    3 C         0.0532 0.0383 0.0680               1.05             1.04
    4 D         0.0549 0.0386 0.0711               1.06             1.04
    5 E         0.0494 0.0336 0.0655               1.05             1.03
    # ℹ 4 more variables: growth_factor_q95 <dbl>, pct_change_mean <dbl>,
    #   pct_change_q5 <dbl>, pct_change_q95 <dbl>

    $slope_diff
    # A tibble: 10 × 10
       contrast     mean       q5     q95 ratio_mean ratio_q5 ratio_q95
       <chr>       <dbl>    <dbl>   <dbl>      <dbl>    <dbl>     <dbl>
     1 A - B     0.0397   0.0187  0.0608       1.04     1.02       1.06
     2 A - C     0.0269   0.00559 0.0481       1.03     1.01       1.05
     3 A - D     0.0251   0.00303 0.0473       1.03     1.00       1.05
     4 A - E     0.0307   0.00858 0.0528       1.03     1.01       1.05
     5 B - C    -0.0129  -0.0340  0.00855      0.987    0.967      1.01
     6 B - D    -0.0147  -0.0366  0.00759      0.985    0.964      1.01
     7 B - E    -0.00909 -0.0311  0.0130       0.991    0.969      1.01
     8 C - D    -0.00176 -0.0238  0.0205       0.998    0.976      1.02
     9 C - E     0.00380 -0.0181  0.0256       1.00     0.982      1.03
    10 D - E     0.00556 -0.0173  0.0276       1.01     0.983      1.03
    # ℹ 3 more variables: pct_diff_mean <dbl>, pct_diff_q5 <dbl>,
    #   pct_diff_q95 <dbl>

### Plots

``` r
plot(fit, type = "predict")
```

![](bhm_files/figure-html/unnamed-chunk-4-1.png)

``` r
plot(fit, type = "slope")
```

![](bhm_files/figure-html/unnamed-chunk-4-2.png)

``` r
plot(fit, type = "contrast")
```

![](bhm_files/figure-html/unnamed-chunk-4-3.png)

``` r
plot(fit, type = "contrast") +
  ggplot2::scale_x_continuous(
    transform = "exp",
    labels = function(z) sprintf("%.2f", exp(z))
  )
```

![](bhm_files/figure-html/unnamed-chunk-4-4.png)

``` r
plot(fit, type = "trace")
```

    $trace_intercept

![](bhm_files/figure-html/unnamed-chunk-4-5.png)

    $trace_slope

![](bhm_files/figure-html/unnamed-chunk-4-6.png)

    $trace_slope_diff

![](bhm_files/figure-html/unnamed-chunk-4-7.png)
