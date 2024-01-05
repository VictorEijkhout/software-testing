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

echo "--- Test if we can compile and run"
../cmake_test_driver.sh -p ${package} -l ${compilelog} has.c 

## ????
# echo "==== Test if we can compile single"
# retcode=0
# ../cmake_test.sh -p ${package} -v cf has.c >>${compilelog} 2>&1 || retcode=$?
# failure $retcode "single precision compilation"

if [ "${compilelog}" = "compile.log" ] ; then
    echo "See: ${compilelog}"
fi
