#!/bin/bash

function modversion {
    m=$1
    module list $m 2>&1 \
	| awk 'p==1 {print $2; p=0} /Currently/ {p=1}'
}

module reset >/dev/null 2>&1
module load intel/19
for v in 1.10.4 1.14.0 ; do 
    module load hdf5/$v >/dev/null 2>&1
    ##v=$( modversion hdf5 )
    echo "compile with hdf5 $v"
    ifort -c -I${TACC_HDF5_INC} fmod.F90
done
