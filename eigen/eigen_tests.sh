#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

##echo "---- Test if we can compile and run"
retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "---- if we can compile and run" \
			has.cxx 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
