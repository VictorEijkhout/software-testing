#!/bin/bash

module reset >/dev/null 2>&1
echo "==== Private modules"
for compiler in intel/19 ; do \
    config=$( echo $compiler | tr -d '/' )
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    cc=mpicc
    for v in 3.19  ; do 
	module load petsc/$v >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
	    includes=$( cd $PETSC_DIR && make --no-print-directory getincludedirs )
	    libs=$( cd $PETSC_DIR && make --no-print-directory getlinklibs )
	    echo "compile with petsc $v"
	    cmdline="$cc -o sanity sanity.c ${includes} ${libs} "
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
