#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

## echo "--- Test if we can compile and run"
../make_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
		       --title "--- if we can compile and run" \
		       has.c 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
