#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

##
## double precision
##
../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "can we compile and run" \
			has.c 

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "double precision header" \
		     -d inc fftw3.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "double precision library" \
		     -d lib libfftw3.so

##
## single precision
##

# does not seem to be a separate header
# ../existence_test.sh -p ${package} -l ${logfile} \
# 		     --title "single precision header" \
# 		     -d inc fftw3f.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "single precision library" \
		     -d lib libfftw3f.so

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "can we single precision" \
			single.c
# should this give output 4? it seems to give 0
