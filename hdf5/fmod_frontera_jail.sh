#!/bin/bash

module reset >/dev/null 2>&1
echo "==== TACC modules"
compiler=intel/19
echo "---- computer $compiler"
module load $compiler
for v in 1.10.4 1.14.0 ; do
    module load hdf5/$v >/dev/null 2>&1
    ##v=$( modversion hdf5 )
    echo "compile with hdf5 $v"
    cmdline="ifort -c -I${TACC_HDF5_INC} fmod.F90"
    echo " .. $cmdline"
    eval $cmdline
done
