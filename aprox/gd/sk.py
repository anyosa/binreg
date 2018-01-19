from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
import scipy
print pd.__path__
print np.__path__
print scipy.__path__

data = pd.read_csv("~/binreg/datasets/d5000/dtrain.csv")

x1 = data['x1']
x2 = data['x2']
features = np.vstack((x1, x2))
features = features.T
X = np.hstack((np.ones((features.shape[0], 1)), features))
y = data['y']

regr = LogisticRegression()
regr.fit(X, y)
print regr.coef_