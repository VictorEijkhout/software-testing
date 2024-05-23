#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../test_options.sh
source ../failure.sh

echo "---- Test if we can compile and run"
../cmake_test_driver.sh -p ${package} -l ${logfile} has.cxx
