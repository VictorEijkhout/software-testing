#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile and run" \
			has.cxx 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
