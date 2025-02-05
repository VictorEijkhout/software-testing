#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile and run with pkgconfig" \
			-t "package" \
			has.cxx 

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile and run with find_package" \
			-t "module" \
			has.cpp

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir inc Eigen/Core
