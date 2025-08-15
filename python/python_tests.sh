#!/bin/bash

echo && echo "Do we have numpy" && echo

python3 -c "import numpy as np; np.__config__.show()" \
    | grep mkl \
	   2>/dev/null

python3 matmult.py

echo && echo "Do we have h5py" && echo

python3 -c "import h5py"

echo && echo "Paramiko test" && echo

python3 localhost.py
