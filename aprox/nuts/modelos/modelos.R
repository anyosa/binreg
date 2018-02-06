mod5 = '
data {                          
int<lower=0> N;          
int<lower=0,upper=1> y[N];  
vector[N] x1;         
vector[N] x2;
}
parameters {
real beta_0;     
real beta_1;        
real beta_2; 
real loglamb;
}
model {
beta_0 ~ normal(0.0,100);
beta_1 ~ normal(0.0,100);
beta_2 ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
for(n in 1:N) 
  y[n] ~ bernoulli(pow(inv_logit( beta_0 + beta_1 * x1[n] + beta_2 * x2[n] ), exp(loglamb)));
}
'

mod7 = '
data {
int<lower=0> N;
int<lower=0,upper=1> y[N];
vector[N] x1;
vector[N] x2;
}
parameters {
real beta_0;
real beta_1;
real beta_2;
real loglamb;
}
model {
beta_0 ~ normal(0.0,100);
beta_1 ~ normal(0.0,100);
beta_2 ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
for(n in 1:N)
  y[n] ~ bernoulli(pow(1/( 1+exp(-beta_0- beta_1*x1[n] - beta_2*x2[n])), exp(loglamb)));
}
'

mod8 = '
data {
int<lower=0> N;
int<lower=0,upper=1> y[N];
vector[N] x1;
vector[N] x2;
}
parameters {
real beta_0;
real beta_1;
real beta_2;
real loglamb;
}
model {
beta_0 ~ normal(0.0,100);
beta_1 ~ normal(0.0,100);
beta_2 ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
for(n in 1:N)
  y[n] ~ bernoulli(pow(logistic_cdf( beta_0+ beta_1*x1[n]+ beta_2*x2[n], 0, 1), exp(loglamb)));
}
'

mod5m = '
data {
int<lower=0> N;
int<lower=0> K;
int<lower=0,upper=1> y[N];
matrix[N,K] X;
}
parameters {
real beta_0;
vector[K] beta;
real loglamb;
}
model {
beta_0 ~ normal(0.0,100);
beta ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
for(n in 1:N)
y[n] ~ bernoulli(pow(inv_logit( beta_0 + X[n]*beta ), exp(loglamb)));
}
'

mod7m = '
data {
int<lower=0> N;
int<lower=0> K;
int<lower=0,upper=1> y[N];
matrix[N,K] X;
}
parameters {
real beta_0;
vector[K] beta;
real loglamb;
}
model {
beta_0 ~ normal(0.0,100);
beta ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
for(n in 1:N)
  y[n] ~ bernoulli(pow(1/( 1+exp(-beta_0 - X[n]*beta)), exp(loglamb)));
}
'

mod8m = '
data {
int<lower=0> N;
int<lower=0> K;
int<lower=0,upper=1> y[N];
matrix[N,K] X;
}
parameters {
real beta_0;
vector[K] beta;
real loglamb;
}
model {
beta_0 ~ normal(0.0,100);
beta ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
for(n in 1:N)
  y[n] ~ bernoulli(pow(logistic_cdf( beta_0 + X[n]*beta, 0 , 1), exp(loglamb)));
}
'