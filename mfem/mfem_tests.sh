#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--in-build-run \
			--title "can we compile and run" \
			ex0.cpp
