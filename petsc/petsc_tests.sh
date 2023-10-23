#!/bin/bash

##
## run tests, given a loaded compiler & petsc version
##

package=petsc

if [ -z "${compilelog}" ] ; then
    compilelog=compile.log
fi

source ../failure.sh

echo "==== Test if we can compile Fortran"
retcode=0
## ./petsc_cmake_test.sh fortran.F90 >>${compilelog} 2>&1 || retcode=$?
../cmake_test.sh -p ${package} fortran.F90 >>${compilelog} 2>&1 || retcode=$?
failure $retcode "fortran compilation"

echo "==== Test if we have python interfaces"
retcode=0
./petsc4py_test.sh >>${compilelog} 2>&1 || retcode=$?
failure $retcode "py interfaces"

echo "==== Test if we have amgx preconditioner"
retcode=0
../cmake_test.sh -p ${package} ksp.c >>${compilelog} 2>&1 || retcode=$?
failure $retcode "amgx compilation"

echo "==== Test size of scalar"
retcode=0
../cmake_test.sh -p ${package} scalar.c >>${compilelog} 2>&1 || retcode=$?
failure $retcode "scalar compilation"
./build/scalar

echo "==== Test size of int"
retcode=0
../cmake_test.sh -p ${package} int.c >>${compilelog} 2>&1 || retcode=$?
failure $retcode "int compilation"
./build/int

if [ "${compilelog}" = "compile.log" ] ; then
    echo "See: ${compilelog}"
fi
