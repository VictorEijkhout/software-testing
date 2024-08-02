#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

##echo "--- Test if we can compile and run"
../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "can we compile and run" \
			has.c 

##echo "--- Test if we can compile and run"
# doesn't work yet
# ../cmake_test_driver.sh -p ${package} -l ${logfile} \
# 			--title "cmake module" \
# 			has.cxx


if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
