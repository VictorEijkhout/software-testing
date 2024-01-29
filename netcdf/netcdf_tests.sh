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

echo "==== Test if we can compile"
retcode=0
../cmake_test_driver.sh -p ${package} -l ${compilelog} sanity.c

if [ "${compilelog}" = "compile.log" ] ; then
    echo "See: ${compilelog}"
fi
