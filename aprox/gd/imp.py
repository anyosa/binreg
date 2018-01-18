import numpy as np
import pandas as pd

def sigmoid(linpred):
    return 1 / (1 + np.exp(-linpred))

def log_likelihood(features, y, coef, lamb):
    linpred = np.dot(features, coef)
    ll = np.sum( y*linpred*lamb - lamb*np.log(1 + np.exp(linpred)) )
    return ll


def logistic_regression(features, target, num_steps, learning_rate, add_intercept=False):
    if add_intercept:
        intercept = np.ones((features.shape[0], 1))
        features = np.hstack((intercept, features))

    weights = np.zeros(features.shape[1])

    for step in xrange(num_steps):
        scores = np.dot(features, weights)
        predictions = sigmoid(scores)

        # Update weights with gradient
        output_error_signal = target - predictions
        gradient = np.dot(features.T, output_error_signal)
        weights += learning_rate * gradient

    return weights

def lpr(features, y, num_steps, learning_rate, add_intercept=False):
    if add_intercept:
        intercept = np.ones((features.shape[0], 1))
        features = np.hstack((intercept, features))

    coef = np.array([0.1,0.1,0.1])
    #print type(coef)

    lamb = np.array([0.1])
    #print type(lamb)
    #ones = np.ones(features.shape[0])
    #dif = ones -y

    for step in xrange(num_steps):
        
        linpred = np.dot(features, coef)
        #print '1',linpred.shape
        #print 'y',y.shape
        #print 'yq',np.dot(y, linpred)
        L = sigmoid(linpred)**lamb

        # Update coef with gradient
        #b0 = bo - learning_rate( (1000**-1) )
        error = (L - y)*lamb
        gradient = (5000**-1)* (np.dot(features.T, error))
        #print 'r',np.prod(np.log(1+np.exp(linpred)))
        glamb = (5000**-1)*(np.prod(np.log(1+np.exp(linpred)))-np.dot(y, linpred))
        #print 'r',glamb.shape
        coef += learning_rate * (-gradient)
        lamb += learning_rate * (-glamb)

    return coef, lamb
#
#def c1(linpred, y, delta):
#    return y * np.exp(delta) / (1 + np.exp(linpred))

#def c2(linpred, y, delta):
#    return ((y-1) * (np.exp(delta) / (1 + np.exp(linpred))) * (sigmoid(linpred)**np.exp(delta)))/(1-(sigmoid(linpred)**np.exp(delta)))

def b2c(linpred, y, delta):
    return y * np.exp(delta) / (1 + np.exp(linpred)) + ((y-1) * (np.exp(delta) / (1 + np.exp(linpred))) * (sigmoid(linpred)**np.exp(delta)))/(1-(sigmoid(linpred)**np.exp(delta)))

def d2c(linpred, y, delta):
    return y*np.log(sigmoid(linpred))*np.exp(delta) + (y-1)*np.log(sigmoid(linpred))*np.exp(delta)*(np.exp(linpred)**np.exp(delta)/((1+np.exp(linpred))**np.exp(delta)+np.exp(linpred)**np.exp(delta)) )


def lpr2(features, y, num_steps, learning_rate, add_intercept=False):
    if add_intercept:
        intercept = np.ones((features.shape[0], 1))
        features = np.hstack((intercept, features))

    coef = np.array([0.1, 0.1, 0.1])
    # print type(coef)

    delta = np.array([0.1])
    # print type(lamb)
    # ones = np.ones(features.shape[0])
    # dif = ones -y

    for step in xrange(num_steps):
        linpred = np.dot(features, coef)
        #print '1',linpred.shape
        # print 'y',y.shape
        # print 'yq',np.dot(y, linpred)
        L = sigmoid(linpred)

        # Update coef with gradient
        # b0 = bo - learning_rate( (1000**-1) )
        error = (L - y) * np.exp(delta)
        gradient = (5000 ** -1) * (np.dot(features.T, error))
        # print 'r',np.prod(np.log(1+np.exp(linpred)))
        glamb = (5000 ** -1) * (np.prod(np.log(1 + np.exp(linpred))) - np.dot(y, linpred))
        # print 'r',glamb.shape
        coef += learning_rate * (-gradient)
        delta += learning_rate * (-glamb)

    return coef, delta

def lpr3(features, y, num_steps, learning_rate, add_intercept=False):
    if add_intercept:
        intercept = np.ones((features.shape[0], 1))
        features = np.hstack((intercept, features))
    m = features.shape[0]
    coef = np.array([0.1, 0.1, 0.1])
    # print type(coef)

    delta = np.array([0.1])
    # print type(lamb)
    # ones = np.ones(features.shape[0])
    # dif = ones -y

    for step in xrange(num_steps):
        linpred = np.dot(features, coef)
        #print '1',linpred.shape
        # print 'y',y.shape
        # print 'yq',np.dot(y, linpred)
        #L = sigmoid(linpred)

        # Update coef with gradient
        # b0 = bo - learning_rate( (1000**-1) )
        gradient = (m ** -1) * (np.dot(features.T, b2c(linpred, y, delta)))
        # print 'r',np.prod(np.log(1+np.exp(linpred)))
        glamb = (m ** -1) * sum(d2c(linpred, y, delta))
        # print 'r',glamb.shape
        coef += learning_rate * (gradient)
        delta += learning_rate * (glamb)

    return coef, delta


data = pd.read_csv("~/Dropbox/lrgd/dat3.csv")

x1 = data['x1']
x2 = data['x2']
features = np.vstack((x1, x2))
features = features.T
y = data['y']

weights = lpr3(features, y,  num_steps = 300000, learning_rate = 5e-5, add_intercept=True)
print weights

#intercept = np.ones((features.shape[0], 1))
#X = np.hstack((intercept, features))
#coef = weights[0]
#lamb = np.exp(weights[1])
#preds = sigmoid(np.dot(X, coef))**lamb
coeftrue= np.array([0.5,1.0,1.0])
lambtrue=5
predstrue = sigmoid(np.dot(X, coeftrue))**lambtrue

#from sklearn.metrics import roc_auc_score
#roc_auc_score(y, preds)
wlr = logistic_regression(features, y, num_steps = 300000, learning_rate = 5e-5, add_intercept=True)
predlr = sigmoid(np.dot(X, coef))

