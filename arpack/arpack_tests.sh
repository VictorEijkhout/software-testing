#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header in arpack subdir" \
		     --dir inc arpack/arpack.h

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			dssimp.f

