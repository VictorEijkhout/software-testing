#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "severely insufficient compile test" \
			sanity.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile create_open" \
			create_open.c

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C header" \
		     --dir inc pnetcdf.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "fortran module" \
		     --dir inc pnetcdf.mod

