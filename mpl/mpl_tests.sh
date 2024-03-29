#!/bin/bash

##
## run tests, given a loaded compiler
##

source ../test_options.sh
source ../failure.sh

echo "---- Test if we can compile CXX with MPL"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} has.cxx
