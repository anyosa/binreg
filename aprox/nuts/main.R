library(rstan)
load("~/Dropbox/Susan/ProjetoBigdata/Rstan/datasets/datlogis.rda")
source("~/Dropbox/Susan/ProjetoBigdata/Rstan/modelos/modelos.R")
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
data = datlogis
remove(datlogis)
#1
dat = list (N = NROW(data),
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
start_time= Sys.time()
fit1 <- stan(model_code = mod1, data = dat,
                chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
time1 = end_time - start_time
#2
dat = list (N = NROW(data),
            p = 3,
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
start_time= Sys.time()
fit2 <- stan(model_code = mod2, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
time2 = end_time - start_time
#3 nao parece bom
dat = list (N = NROW(data),
            K = 2,
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
start_time= Sys.time()
fit3 <- stan(model_code = mod3, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
time3 = end_time - start_time
#4
dat = list (N = NROW(data),
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
start_time= Sys.time()
fit4 <- stan(model_code = mod4, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
#5
dat = list (N = NROW(data),
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
start_time= Sys.time()
fit5 <- stan(model_code = mod5, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
time5 = end_time - start_time
#6 demora mas
dat = list (N = NROW(data),
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
start_time= Sys.time()
fit6 <- stan(model_code = mod6, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
time6 = end_time - start_time