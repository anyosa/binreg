import scipy
import numpy as np

def pcauchy(x, location, scale, shape):
    d = scipy.stats.cauchy(location, scale).cdf(x)
    powd = d ** shape
    return(powd)

def genpcauchy(n, betavec, shape):
    beta0 = betavec[0]
    beta = betavec[1:]
    x1 = scipy.stats.uniform.rvs(size=n)
    x2 = scipy.stats.norm.rvs(size=n)
    X = np.column_stack((x1,x2))
    prob = pcauchy(beta0 + np.dot(beta,X.T), 0, 1, shape)
    y = scipy.stats.bernoulli.rvs(p = prob)
    return np.column_stack((X,y))






