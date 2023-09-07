#!/bin/bash

module reset >/dev/null 2>&1
echo "==== TACC modules"
module load intel/19
for v in 1.10.4 1.14.0 ; do 
    module load hdf5/$v >/dev/null 2>&1
    ##v=$( modversion hdf5 )
    echo "compile with hdf5 $v"
    ifort -c -I${TACC_HDF5_INC} fmod.F90
done

echo "==== private modules"
source ${HOME}/Software/env_ls6_intel19.sh >/dev/null 2>&1
for v in 1.14.0 ; do 
    echo "load hdf5 $v"
    module load hdf5/$v >/dev/null 2>&1
    ##v=$( modversion hdf5 )
    cmdline="ifort -c -I${TACC_HDF5_INC} fmod.F90"
    echo " .. compile hdf5 $v : $cmdline"
    eval $cmdline
done
