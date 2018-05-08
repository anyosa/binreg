from gen import genpcauchy
import numpy as np
import pystan

data = genpcauchy(n=1000, betavec=np.array([0.5, 1.0, 1.0]), shape=1)

dat = {'N' : data.shape[0],
       'x1' : data[:,0],
       'x2' : data[:,1],
       'y' : data[:,2].astype(int)}

mod5 = """
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
"""

sm = pystan.StanModel(model_code=mod5)
fit = sm.sampling(data=dat, iter=3000, chains=4, n_jobs = -1)
print(fit)