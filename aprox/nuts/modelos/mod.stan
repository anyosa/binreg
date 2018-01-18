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
#generated quantities {         # simulate quantities of interest
#real y_hat;                    # create a new variable for the predicted values
#y_hat <- inv_logit(alpha + b_educate * 10 + b_income * 15 + b_age * 40 + b_age_sq * 1600); # model
#}