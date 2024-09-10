#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "compile and run with pkgconfig" \
			-t "package" \
			has.cxx 

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "compile and run with find_package" \
			-t "module" \
			has.cpp

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     -d inc Eigen/Core
