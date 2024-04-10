#!/bin/bash

##
## run tests, given a loaded compiler
##

source ../test_options.sh
source ../failure.sh

echo "---- Test if we can compile and run"
../cmake_test_driver.sh -p ${package} -l ${logfile} has.cpp

echo "---- Test file system"
../cmake_test_driver.sh -p ${package} -l ${logfile} system.cpp

echo "---- Test graph viz"
../cmake_test_driver.sh -p ${package} -l ${logfile} graphviz.cpp

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
