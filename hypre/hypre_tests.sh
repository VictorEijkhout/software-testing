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

echo "---- Test if we can compile"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} \
    --cmake "-DHYPRE_INCLUDE_DIRS=${TACC_HYPRE_INC},-DHYPRE_LIBRARY_DIRS=${TACC_HYPRE_LIB},-DHYPRE_LIBRARIES=libHYPRE.so" \
    has.c
