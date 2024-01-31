#!/bin/bash

package=phdf5

module reset >/dev/null 2>&1
echo "==== TACC modules"
for compiler in intel/19 intel/23 gcc/9 ; do \
    retcode=0 && module load ${compiler} || retcode=$?
    if [ $retcode -ne 0 ] ; then 
	echo && echo "Could not load compiler $compiler" && echo 
    else 
	echo "---- compiler module: ${compiler}"
	case $compiler in ( intel* ) cc=ifort ;; ( gcc* ) cc=gfortran ;; esac
	for v in 1.10.4 1.14.0 ; do 
	    module load ${package}/$v >/dev/null 2>&1
	    if [ $? -eq 0 ] ; then
		if [ ! -z "${TACC_HDF5_INC}" ] ; then 
		    inc=${TACC_HDF5_INC}
		else inc=${TACC_PHDF5_INC} ; fi
		cmdline="${cc} -I${inc} -c fmod.F90"
		echo " .. compile ${package} $v : $cmdline"
		retcode=0 && eval $cmdline || retcode=$?
		if [ ${retcode} -ne 0 ] ; then 
		    echo && echo "    ERROR compilation failed" && echo
		fi
	    else
		echo " .. could not load ${package}/$v"
	    fi
	done
    fi
done
