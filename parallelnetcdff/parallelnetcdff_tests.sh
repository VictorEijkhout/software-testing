#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

##
## Tests
##

../existence_test.sh ${standardflags} \
		     --title "fortran module" \
		     --dir inc netcdf.mod

../cmake_test_driver.sh ${standardflags} \
			--title "can we compile parallel F" \
			simple_xy_par.F90

../existence_test.sh ${standardflags} \
		     --title "config program" \
		     --dir bin nf-config

