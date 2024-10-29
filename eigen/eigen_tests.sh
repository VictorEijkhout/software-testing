#!/bin/bash

##
## run tests, given a loaded environment
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

##
## Tests
##
../cmake_test_driver.sh ${standardflags} \
			--title "compile and run with pkgconfig" \
			-t "package" \
			has.cxx 

../cmake_test_driver.sh ${standardflags} \
			--title "compile and run with find_package" \
			-t "module" \
			has.cpp

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir inc Eigen/Core
