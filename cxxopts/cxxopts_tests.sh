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

echo "---- Test if we can compile and run"
retcode=0
../cmake_test.sh -p ${package} has.cxx >>${compilelog} 2>&1 || retcode=$?
failure $retcode "basic compilation"
if [ $retcode -eq 0 ] ; then 
    ./build/has -h || retcode=$?
    failure $retcode "basic run"
fi

if [ "${compilelog}" = "compile.log" ] ; then
    echo "See: ${compilelog}"
fi
