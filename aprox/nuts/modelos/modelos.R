#https://github.com/danilofreire/r-scripts/blob/master/stan-logistic-regression.R
mod1 = '
data {                          
int<lower=0> N;               
int<lower=0,upper=1> y[N];  
vector[N] x1;             
vector[N] x2;             
}
parameters {
real b0;                    
real b1;                
real b2; 
}
model {
b0 ~ normal(0,100);       
b1 ~ normal(0,100);     
b2 ~ normal(0,100);
y ~ bernoulli_logit(b0 + b1 * x1 + b2 * x2 ); 
}
'
mod2 = '
data {
int<lower=0> N;
int<lower=0> p;
int<lower=0,upper=1> y[N];  
vector[N] x1;             
vector[N] x2;
}
parameters {
real beta[p];
}
transformed parameters  {
real<lower=0> odds[N];
real<lower=0, upper=1> prob[N];
for (i in 1:N) {
odds[i] <- exp(beta[1] + beta[2]*x1[i] + beta[3]*x2[i]);
prob[i] <- odds[i] / (odds[i] + 1);
}
}
model {
y ~ bernoulli(prob);
}
'

mod3 = '
data {                          
int<lower=0> N;
int<lower=0> K; 
int<lower=0,upper=1> y[N];  
vector[N] x1;             
vector[N] x2;             
}
parameters {
real b0;
vector[K] beta; 
}
model {
b0 ~ normal(0,100);
beta ~ normal(0,100);
for(n in 1:N) {
y[n] ~ bernoulli(inv_logit( b0 + beta[1] * x1 + beta[2] * x2 ));
}
}
'

mod4 = '
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
}
model {
y ~ bernoulli_logit(beta_0 + beta_1 * x1 + beta_2 * x2);
}
'
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
mod6 = '
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
transformed parameters  {
vector[N] prob;
for (n in 1:N)
prob[n] = pow(inv_logit( beta_0 + beta_1 * x1[n] + beta_2 * x2[n] ), exp(loglamb));
}
model {
beta_0 ~ normal(0.0,100);
beta_1 ~ normal(0.0,100);
beta_2 ~ normal(0.0,100);
loglamb ~ uniform(-2,2);
y ~ bernoulli(prob);
}
'
