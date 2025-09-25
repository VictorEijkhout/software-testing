#!/bin/bash

source ../test_setup.sh

##
## Tests
##

echo && echo "Do we have numpy" && echo
python3 -c "import numpy as np; np.__config__.show()" \
    | grep mkl \
	   2>/dev/null

../python_test_driver.sh ${standardflags} -l ${logfile} \
    --title "numpy matmult" \
    matmult.py

#
# libhdf5.so
# gcc 9    : python 3.7.0 & hdf5 103
# gcc 13   : python 3.8.2 & partially initialized module h5py
#
# intel 19 : python 3.7.0 & 103
# 10.4 10.11 : 103
# 12.0 12.2 : 200
# 14 : 310.various
#
# intel 23 : python 3.9.2 & 103
# 10.11 : 103
# 14 : 310.various
#
# all hdf5 versions have 310
#
# intel 24 : python 3.7.0 & 103
#
../python_test_driver.sh ${standardflags} -l ${logfile} \
    --title "hdf5 importing" \
    importh5.py

echo && echo "Subprocess use" && echo
answer=$( python3 multiple.py )
if [ "${answer}" != "2" ] ; then
    echo "ERROR should have output <<2>> not <<${answer}>>"
fi

../python_test_driver.sh ${standardflags} -l ${logfile} \
    --title "ssh to localhost" \
    localhost.py

# echo && echo "Paramiko test" && echo
# python3 localhost.py
# if [ ! -f "paramiko_test.dat" ] ; then
#     echo "ERROR failed to create file through paramiko ssh connection"
# fi

if [ -z "${SLURM_JOBID}" ] ; then
    echo && echo "WARNING skipping mpi test because not in SLURM" && echo
else
    echo && echo "MPI4PY test" && echo
    ibrun -n 2 python3 importmpi.py
fi
