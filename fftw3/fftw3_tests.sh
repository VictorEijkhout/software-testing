#!/bin/bash

source ../test_setup.sh

##
## Tests
##

##
## double precision
##
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile and run" \
			has.c 

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "double precision header" \
		     --dir inc fftw3.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "double precision library" \
		     --dir lib libfftw3.so

##
## Fortran
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "has F90" \
			has.F90
