#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "math header" \
		     --dir inc gsl/gsl_math.h

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile and run" \
			solve.cxx 

