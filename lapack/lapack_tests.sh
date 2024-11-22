#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -m -p ${package} -l ${logfile} ${runflag} \
			--title "compile F lapack95" \
			lapack95.F90

