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
../cmake_test_driver.sh ${standardflags} \
			--title "can we compile and run" \
			solve.cxx 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
