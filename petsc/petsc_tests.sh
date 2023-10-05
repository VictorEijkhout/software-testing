#!/bin/bash

##
## run tests, given a loaded compiler
##

if [ -z "${package}" ] ; then
    echo "Error: supply package=..." && exit 1 
fi
if [ -z "${compilelog}" ] ; then
    compilelog=compile.log
fi

source ../failure.sh

echo "==== Test if we can compile Fortran"
retcode=0
./petsc_cmake_test.sh fortran.F90 >>${compilelog} 2>&1 || retcode=$?
failure $retcode "fortran compilation"

echo "==== Test if we have python interfaces"
retcode=0
./petsc4py_test.sh >>${compilelog} 2>&1 || retcode=$?
failure $retcode "py interfaces"

if [ "${compilelog}" = "compile.log" ] ; then
    echo "See: ${compilelog}"
fi
