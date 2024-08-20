#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

echo "Test if we can compile"
../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			has.F90

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
