import scipy.stats
import numpy as np

def pcauchy(x, location, scale, shape):
    d = scipy.stats.cauchy(location, scale).cdf(x)
    powd = d ** shape
    return(powd)

def genpcauchy(n, betavec, shape):
    beta0 = betavec[0]
    beta = betavec[1:]
    x1 = scipy.stats.uniform.rvs(size=n, loc=-2, scale=4)
    x2 = scipy.stats.norm.rvs(size=n)
    X = np.column_stack((x1,x2))
    prob = pcauchy(beta0 + np.dot(beta,X.T), 0, 1, shape)
    y = scipy.stats.bernoulli.rvs(p = prob)
    return np.column_stack((X,y))

dat = genpcauchy(1000, np.array([-3.7,-0.51,11.2]), shape = 2.6)
dat.mean(axis =0)

np.savetxt("datcauchy.csv", dat, delimiter=",")



