#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

echo "---- Test if we can compile and run"
../cmake_test_driver.sh -p ${package} -l ${logfile} has.cpp

echo "---- Test file system"
../cmake_test_driver.sh -p ${package} -l ${logfile} system.cpp

echo "---- Test graph viz"
../cmake_test_driver.sh -p ${package} -l ${logfile} graphviz.cpp

echo "---- Test program_options"
found=$( find $TACC_BOOST_DIR -name \*.cmake | grep program_options | wc -l )
if [ ${found} -eq 0 ] ; then
    echo "FAILED to find cmake files"
else
    echo "     found"
fi

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
