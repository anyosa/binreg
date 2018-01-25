library(rstan)
load("~/binreg/datasets/datlogis10k.rda")
source("~/binreg/aprox/nuts/modelos/modelos.R")
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
data = datlogis
remove(datlogis)
time = c()
#5
dat = list (N = NROW(data),
            x1 =data$x1,
            x2 = data$x2,
            y = data$y)
for (i in 1:3) {
start_time= Sys.time()
fit <- stan(model_code = mod5, data = dat,
             chains = 3, iter = 3000, warmup = 500, thin = 10, cores = 4)
end_time = Sys.time()
time = append(time, end_time - start_time)
}

#time without any setup
#time [1] 13.68233 13.24597 12.94010
#mc core
#time[1] 14.902984  7.233172 11.591521
#doParallel
#time
#[1] 14.05746 10.83410 12.62611

