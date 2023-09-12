#!/bin/bash

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
    for v in 3.19.4  ; do 
	module load petsc/$v >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
	    includes=$( cd $PETSC_DIR && make --no-print-directory getincludedirs )
	    libs=$( cd $PETSC_DIR && make --no-print-directory getlinklibs )
	    echo "compile with petsc $v"
	    cmdline="$cc -o hdf5 hdf5.c ${includes} ${libs} "
	    echo " .. $cmdline"
	    retcode=0 && eval $cmdline || retcode=$?
	    if [ ${retcode} -ne 0 ] ; then 
		echo && echo "ERROR compilation failed with compiler=${compiler} and petsc/${v}" && echo
	    fi
	else
	    echo "could not load petsc/$v"
	fi
    done
done
