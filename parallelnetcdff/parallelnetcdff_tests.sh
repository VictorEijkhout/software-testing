#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh ${standardflags} \
		     --title "fortran module" \
		     --dir inc netcdf.mod

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile parallel F" \
			simple_xy_par.F90

../existence_test.sh ${standardflags} \
		     --title "config program" \
		     --dir bin nf-config

