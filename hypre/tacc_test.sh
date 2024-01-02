#!/bin/bash

package=fftw3
version=3.3.10

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "    testing ${package}/${version}"
echo "================"
echo 
compilelog=local_test.log
rm -f ${compilelog}
for compiler in intel/19 intel/23 gcc/9 gcc/11 gcc/13 ; do \
    retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... Unknown configuration ${compiler}" | tee -a ${compilelog}
    else
	echo "==== Configuration: ${compiler}" | tee -a ${compilelog}
	module load ${package}/${version} >/dev/null 2>&1
	if [ $? -eq 0 ] ; then

	    source fftw3_tests.sh

	else
	    echo "WARNING could not load ${package}/${version}"
	fi
    fi
done
echo && echo "See: ${compilelog}" && echo

