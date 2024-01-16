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

    # echo && echo "==== Configuration: ${config}"
    # module load ${compiler} >/dev/null 2>&1
    # module load ${package}/${version}${extension} >/dev/null 2>&1
    # if [ $? -eq 0 ] ; then

    # 	case ${compiler} in ( intel* ) fc=ifort ;; ( gcc* ) fc=gfortran ;; esac
    # 	case ${compiler} in ( intel* ) cc=icc ;; ( gcc* ) cc=gcc ;; esac

echo "==== Test if we can compile C"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} has.c

echo "==== Test if we can compile Fortran"
../cmake_test_driver.sh -m -p ${package} -l ${compilelog} has.F90
