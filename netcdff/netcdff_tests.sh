#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../test_options.sh
source ../failure.sh

echo "---- Test if we can compile"
../cmake_test_driver.sh -p ${package} -l ${logfile} has.F90

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
