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
echo "==== Local modules"
echo "================"
echo 
compilelog=local_test.log
for compiler in intel/19 intel/23 gcc/9 gcc/13 ; do \
    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}"
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh >/dev/null 2>&1
    module load ${package}/${version} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	source fftw3_tests.sh

    else
	echo "WARNING could not load ${package}/${version}"
    fi
done
echo && echo "See: ${compilelog}" && echo

