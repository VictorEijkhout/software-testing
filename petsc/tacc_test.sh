#!/bin/bash

if [ $# -lt 1 ] ; then 
    echo "Usage: $0 program" && exit 1
fi

module reset >/dev/null 2>&1
echo "================"
echo "==== Local modules"
echo "================"
echo 
for compiler in intel/19 intel/23 gcc/9 gcc13 ; do \
    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}"
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    cc=mpicc
    for v in 3.19.4  3.19.5 ; do 
	module load petsc/$v >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
	    ./petsc_test.sh fortran.F90
	else
	    echo "WARNING could not load petsc/$v"
	fi
    done
done
