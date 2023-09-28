#!/bin/bash

package=fftw3

function failure() {
    if [ $1 -gt 0 ] ; then 
	echo && echo "ERROR failed $2" && echo 
    fi
}

version=3.19
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
for compiler in intel/19 intel/23 gcc/9 gcc/13 ; do \
    config=$( echo $compiler | tr -d '/' )
    echo "==== Configuration: ${config}"
    source ${HOME}/Software/env_${TACC_SYSTEM}_${config}.sh
    module load petsc/${version} >/dev/null 2>&1
    if [ $? -eq 0 ] ; then

	echo "==== Test if we can compile Fortran"
	retcode=0
	./petsc_cmake_test.sh fortran.F90 >/dev/null 2>&1 || retcode=$?
	failure $retcode "fortran compilation"

	echo "==== Test if we have python interfaces"
	retcode=0
	./petsc4py_test.sh >/dev/null 2>&1 || retcode=$?
	failure $retcode "py interfaces"
    else
	echo "WARNING could not load petsc/${version}"
    fi
done

