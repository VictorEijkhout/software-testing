#!/bin/bash

package=fftw3

##
## test all programs for this package,
## looping over locally available modules
##

function failure() {
    if [ $1 -gt 0 ] ; then 
	echo && echo "ERROR failed $2" && echo 
    fi
}

version=3.3.10
function usage() {
    echo "Usage: $0 [ -v version (default=${version} ]"
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
while [ $# -gt 0 ] ; do
    if [ "$1" = "-v" ] ; then
	shift && version="$1" && shift
    fi
done

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

	echo "==== Test if we can compile"
	retcode=0
	../cmake_test.sh -p ${package} has.c >${compilelog} 2>&1 || retcode=$?
	failure $retcode "basic compilation"

	echo "==== Test if we can compile single"
	retcode=0
	../cmake_test.sh -p ${package} has.cf >${compilelog} 2>&1 || retcode=$?
	failure $retcode "single precision compilation"

    else
	echo "WARNING could not load ${package}/${version}"
    fi
done
echo && echo "See: ${compilelog}" && echo

