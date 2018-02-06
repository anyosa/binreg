library(rstan)
load("~/binreg/datasets/datlogis.rda")
source("~/binreg/aprox/nuts/modelos/modelos.R")
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
data = datlogis
remove(datlogis)
times = c()
sums = c()
#5
dat = list (N = NROW(data),
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
for (i in 1:10) {
start_time= Sys.time()
fit <- stan(model_code = mod7, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 16)
end_time = Sys.time()
times = append(times, end_time - start_time)
sums = append(sums, summary(fit, pars = c("beta_0", "beta_1", "beta_2", "loglamb"))$summary)
}
save(list=c("times", "sums"), file="/home/ubuntu/binreg/aprox/nuts/rstan/objects/mod7.rda")

#time_mod5


#matrix forms
library(rstan)
load("~/binreg/datasets/datlogis.rda")
source("~/binreg/aprox/nuts/modelos/modelos.R")
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
data = datlogis
remove(datlogis)
times = c()
sums = c()
dat = list (N = NROW(data),
            X = data[,1:2],
            y = data$y,
            K = NCOL(data[,1:2]))
for (i in 1:10) {
start_time= Sys.time()
fit <- stan(model_code = mod5m, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 16)
end_time = Sys.time()
times = append(times, end_time - start_time)
sums = append(sums, summary(fit, pars = c("beta_0", "beta", "loglamb"))$summary)
}
save(list=c("times", "sums"), file="/home/ubuntu/binreg/aprox/nuts/rstan/objects/mod5m.rda")
