#!/bin/bash

##
## run tests, given a loaded compiler
##

source ../test_options.sh
source ../failure.sh

echo "---- Test if we can compile C"
../cmake_test_driver.sh -l ${logfile} has.c

echo "---- Test if we can compile C++"
../cmake_test_driver.sh -l ${logfile} hasx.cxx

echo "---- Test if we can compile Fortran"
../cmake_test_driver.sh -l ${logfile} fmod.F90
