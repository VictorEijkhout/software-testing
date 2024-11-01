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
			--title "compile with Fortran module (This test fails locally because libnetcdf and libnetcdff are not in the same directory)" \
			has.F90

../existence_test.sh ${standardflags} \
		     --title "config program" \
		     --dir bin nf-config

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
