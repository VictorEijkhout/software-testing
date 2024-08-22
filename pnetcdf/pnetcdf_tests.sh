#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "severly insufficient compile test" \
			sanity.c

../existence_test.sh -p ${package} -l ${logfile} ${runflag} \
		     --title "C header" \
		     -d inc pnetcdf.h

../existence_test.sh -p ${package} -l ${logfile} ${runflag} \
		     --title "fortran module" \
		     -d inc pnetcdf.mod

