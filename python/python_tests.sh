#!/bin/bash

echo && echo "Do we have numpy" && echo

python3 -c "import numpy as np; np.__config__.show()" \
    | grep mkl \
	   2>/dev/null

echo && echo "Do we have h5py" && echo

python3 -c "import h5py"
