#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${loadpackage} -l ${logfile} \
		     --title "fortran module" \
		     -d inc netcdf.mod

../cmake_test_driver.sh -p ${loadpackage} -l ${logfile} ${runflag} \
			--title "compile with Fortran module" \
			has.F90

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
