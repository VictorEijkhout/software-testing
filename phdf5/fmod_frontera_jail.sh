#!/bin/bash

module reset >/dev/null 2>&1
echo "==== TACC modules"
for compiler in intel/19 intel/23 gcc/9 ; do
    echo "---- computer $compiler"
    case $compiler in ( intel* ) ifort=ifort ;; ( gcc* ) ifort=gfortran ;; esac
    module load $compiler >/dev/null 2>&1
    for v in 1.10.4 1.14.0 ; do
        module load hdf5/$v >/dev/null 2>&1
        if [ $? -eq 0 ] ; then
            echo "compile with hdf5 $v"
            cmdline="$ifort -c -I${TACC_HDF5_INC} fmod.F90"
            echo " .. $cmdline"
            eval $cmdline
        else
            echo "could not load hdf5 $v"
        fi
    done
done

