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

# echo "---- Test if we can compile C"
# ../cmake_test_driver.sh -p ${package} -l ${compilelog} has.c

echo "---- Test if we can compile Fortran"
../cmake_test_driver.sh -p ${package} -l ${compilelog} dssimp.f

