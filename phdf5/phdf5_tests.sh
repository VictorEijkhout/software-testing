#!/bin/bash

##
## run tests, given a loaded compiler
##


source ../failure.sh

echo "---- Test if we can compile C"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} has.c

echo "---- Test if we can compile Fortran"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} fmod.F90
