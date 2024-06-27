import numpy as np

n = 10000
A = np.eye( n, dtype=np.float32 )
B = np.eye( n, dtype=np.float32 )
C = np.zeros( [n,n], dtype=np.float32 )

np.dot(A,B,out=C)

