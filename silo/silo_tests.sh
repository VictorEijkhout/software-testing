#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../test_options.sh
source ../failure.sh

echo "---- Test point functions"
../cmake_test_driver.sh -l ${logfile} point.c

