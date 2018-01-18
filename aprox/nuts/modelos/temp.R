mod.stan = '
data {                          
int<lower=0> N;                # number of observations
int<lower=0,upper=1> y[N];  # setting the dependent variable (vote) as binary
vector[N] x1;             # independent variable 1
vector[N] x2;              # independent variable 2
}
#transformed data {
#vector[N] age_sq;              # create new variable (4), age squared (no dots in the variable name)
#age_sq <- age .* age;          # formula for the variable, do not forget the . before multiplication
#}
parameters {
real b0;                    # intercept
real b1;                # beta for educate, etc
real b2; 
}
model {
b0 ~ normal(0,100);         # you can set priors for all betas
b1 ~ normal(0,100);     # if you prefer not to, uniform priors will be used
b2 ~ normal(0,100);
y ~ bernoulli_logit(b0 + b1 * x1 + b2 * x2 ); # model
}
'
mod1 = """
data {                          
int<lower=0> N;                # number of observations
int<lower=0,upper=1> y[N];  # setting the dependent variable (vote) as binary
vector[N] x1;             # independent variable 1
vector[N] x2;              # independent variable 2
}
transformed data {
vector[N] age_sq;              # create new variable (4), age squared (no dots in the variable name)
age_sq <- age .* age;          # formula for the variable, do not forget the . before multiplication
}
parameters {
real alpha;                    # intercept
real b_educate;                # beta for educate, etc
real b_income; 
real b_age;
real b_age_sq; 
}
model {
alpha ~ normal(0,100);         # you can set priors for all betas
b_educate ~ normal(0,100);     # if you prefer not to, uniform priors will be used
b_income ~ normal(0,100);
b_age ~ normal(0,100);
b_age_sq ~ normal(0,100);
vote ~ bernoulli_logit(alpha + b_educate * educate + b_income * income + b_age * age + b_age_sq * age_sq); # model
}
generated quantities {         # simulate quantities of interest
real y_hat;                    # create a new variable for the predicted values
y_hat <- inv_logit(alpha + b_educate * 10 + b_income * 15 + b_age * 40 + b_age_sq * 1600); # model
}
"""

mod2 = """
data {
int<lower=0> N;
int<lower=0> p;
int death[N];
int<lower=0>  qsmk[N];
int<lower=0>  sex[N];
real<lower=0> age[N];
int<lower=0>  race[N];
real<lower=0> smokeyrs[N];
}
parameters {
real beta[p];
}
transformed parameters  {
real<lower=0> odds[N];
real<lower=0, upper=1> prob[N];
for (i in 1:N) {
odds[i] <- exp(beta[1] + beta[2]*qsmk[i] + beta[3]*sex[i] + beta[4]*age[i] + beta[5]*race[i] + beta[6]*smokeyrs[i]);
prob[i] <- odds[i] / (odds[i] + 1);
}
}
model {
death ~ bernoulli(prob);
}
"""

mod3 = """
data {
int N; // number of obs (pregnancies)
int M; // number of groups (women)
int K; // number of predictors

int y[N]; // outcome
row_vector[K] x[N]; // predictors
int g[N];    // map obs to groups (pregnancies to women)
}
parameters {
real alpha;
real a[M]; 
vector[K] beta;
real<lower=0,upper=10> sigma;  
}
model {
alpha ~ normal(0,100);
a ~ normal(0,sigma);
beta ~ normal(0,100);
for(n in 1:N) {
y[n] ~ bernoulli(inv_logit( alpha + a[g[n]] + x[n]*beta));
}
}
"""

mod4 = """
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
"""
