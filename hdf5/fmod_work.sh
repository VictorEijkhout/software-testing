#!/bin/bash

echo "==== private modules"
source ${HOME}/Software/env_${TACC_SYSTEM}_intel19.sh >/dev/null 2>&1
for v in 1.14.0 ; do 
    echo "load hdf5 $v"
    module load hdf5/$v >/dev/null 2>&1
    cmdline="ifort -c -I${TACC_HDF5_INC} fmod.F90"
    echo " .. compile hdf5 $v : $cmdline"
    eval $cmdline
done
