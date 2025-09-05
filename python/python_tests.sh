#!/bin/bash

echo && echo "Do we have numpy" && echo
python3 -c "import numpy as np; np.__config__.show()" \
    | grep mkl \
	   2>/dev/null

echo && echo "Actually use numpy" && echo
python3 matmult.py

echo && echo "Do we have h5py" && echo
python3 -c "import h5py"

echo && echo "Subprocess use" && echo
answer=$( python3 multiple.py )
if [ "${answer}" != "2" ] ; then
    echo "ERROR should have output <<2>> not <<${answer}>>"
fi

echo && echo "Paramiko test" && echo
python3 localhost.py
if [ ! -f "paramiko_test.dat" ] ; then
    echo "ERROR failed to create file through paramiko ssh connection"
fi

if [ -z "${SLURM_JOBID}" ] ; then
    echo && echo "WARNING skipping mpi test because not in SLURM" && echo
else
    echo && echo "MPI4PY test" && echo
    ibrun -n 2 python3 importmpi.py
fi
