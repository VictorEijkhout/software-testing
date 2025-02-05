#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../make_test_driver.sh ${standardflags} -l ${logfile} \
		       --title "compile and run" \
		       has.c 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
