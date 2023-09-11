#!/bin/bash

if [ "$1" = "-h" ] ; then 
    echo "Usage: $0 [ -p ] "
    exit 0
fi

# sequential hdf5 by default, parallel with "-p" option
package=hdf5
if [ "$1" = "-p" ] ; then
    echo "Not functional" && exit 0
    package=phdf5
fi

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
		## both packages define HDF5 variables
		cmdline="${cc} -I${TACC_HDF5_INC} -c fmod.F90"
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
