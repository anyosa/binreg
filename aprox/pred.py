import numpy as np
import pandas as pd
from sklearn.metrics import roc_auc_score, log_loss,mean_absolute_error, explained_variance_score, roc_curve

def sigmoid(linpred):
    return 1 / (1 + np.exp(-linpred))

data = pd.read_csv("~/binreg/datasets/d5000/dtest.csv")
x1 = data['x1']
x2 = data['x2']
y = data['y']
features = np.vstack((x1, x2))
features = features.T
X = np.hstack((np.ones((features.shape[0], 1)), features))
#NUTS
#time 587.166928053
betanuts = np.array([.92, .92, 1.04])
lambnuts = np.array([np.exp(-1.23)])
prednuts = sigmoid(np.dot(X, betanuts))**lambnuts #0.76710965376
#moda nuts:
betanutsm = np.array([.8047, .9339, 1.0537])
lambnutsm = np.array([np.exp(-1.3996)])
prednutsm = sigmoid(np.dot(X, betanutsm))**lambnutsm

#gd 30,000: time 1382.58 [0.44068471, 0.17409238, 0.17035384]) np.exp(-0.45436075)
#30,000
#7907.76228118
#(array([0.48687727, 0.65022362, 0.62780567]), array([-1.85529693]))
betagd = np.array([0.48687727, 0.65022362, 0.62780567])
lambgd = np.array([np.exp(-1.85529693)])
predgd = sigmoid(np.dot(X, betagd))**lambgd #0.766564523589

betask = np.array([ 1.15597381 , 0.71379882 , 0.77940496])
predsk = sigmoid(np.dot(X, betask))

print roc_auc_score(y, prednuts), log_loss(y, prednuts),mean_absolute_error(y, prednuts), explained_variance_score(y, prednuts)
print roc_auc_score(y, prednutsm), log_loss(y, prednutsm),mean_absolute_error(y, prednutsm), explained_variance_score(y, prednutsm)
print roc_auc_score(y, predgd), log_loss(y, predgd), mean_absolute_error(y, predgd), explained_variance_score(y, predgd)
print roc_auc_score(y, predsk), log_loss(y, predsk), mean_absolute_error(y, predsk), explained_variance_score(y, predsk)