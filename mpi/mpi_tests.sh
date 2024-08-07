#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

##echo "---- Test if we can compile f90"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} \
			--title "---- if we can compile f90" \
			mpif90.c

##echo "---- Test if we can compile f08"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} \
			--title "---- if we can compile f08" \
			mpif08.c
