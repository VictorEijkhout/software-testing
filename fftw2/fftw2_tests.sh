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
../make_test_driver.sh ${standardflags} \
		       --title "compile and run" \
		       has.c 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
