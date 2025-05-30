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
## single precision
##

# does not seem to be a separate header
# ../existence_test.sh -p ${package} -l ${logfile} \
# 		     --title "single precision header" \
# 		     --dir inc fftw3f.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "single precision library" \
		     --dir lib libfftw3f.so

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we single precision" \
			single.c
# should this give output 4? it seems to give 0

##
## Fortran
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "has F90" \
			has.F90
