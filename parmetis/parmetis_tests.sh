#!/bin/bash

##
## run tests, given a loaded compiler
##


source ../failure.sh

echo "---- Test if we can compile"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} has.c
