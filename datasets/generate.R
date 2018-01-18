ppower <- function(type,eta,lambda){
  probs <- list(
    pl = function(eta,lambda) plogis(eta)**lambda,
    #plr = function(eta,lambda) 1-plogis(-eta)**lambda,
    #pp = function(eta,lambda) pnorm(eta)**lambda,
    #ppr = function(eta,lambda) 1-pnorm(-eta)**lambda,
    pc = function(eta,lambda) pcauchy(eta)**lambda
    #pcr = function(eta,lambda) 1-pcauchy(-eta)**lambda,
  )
  return(probs[[type]](eta,lambda))
}

genpower <- function(n,betavec,lambda,type){
  #beta0 = betavec[1]
  #beta = c(betavec[-1])
  beta0 = betavec[1]
  #beta1 = betavec[2]
  #beta2 = betavec[3]
  beta = betavec[-1]
  set.seed(123)
  x1 = runif(n, -2, 2)
  x2 = rnorm(n, 0, 1)
  X = as.matrix(cbind(x1,x2))
  #X = matrix(runif(n*NROW(beta),-3,3),ncol=NROW(beta))
  prob = ppower(type,beta0+X%*%beta,lambda)
  rm(list=".Random.seed", envir=globalenv()) 
  y = numeric()
  for(i in 1:n){y[i] = rbinom(1,1,prob[i])}
  return(data.frame(cbind(X,y)))
}

datlogis = genpower (n=1000, betavec = c(0.5, 1, 1),lambda = 1, type = "pl")
#datlogis = genpower (n=5000, betavec = c(0.5, 1, 1),lambda = 0.2, type = "pl")
datcauchy = genpower (n=1000, betavec = c(0.5, 1, 1),lambda = 1, type = "pc")

save(datlogis, file = ("datlogis.rda"))
save(datcauchy, file = ("datcauchy.rda"))