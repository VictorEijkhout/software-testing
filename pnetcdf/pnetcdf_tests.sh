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

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "compile create_open" \
			create_open.c

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C header" \
		     --dir inc pnetcdf.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "fortran module" \
		     --dir inc pnetcdf.mod

