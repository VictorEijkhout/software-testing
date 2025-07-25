#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "h header in arpack subdir" \
		     --dir inc arpack/parpack.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "h header in arpack subdir" \
		     --dir inc arpack/parpack.hpp

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			issue46.f

