#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "---- compile and run with pkgconfig" \
			-t "package" \
			has.cxx 

retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "---- compile and run with find_package" \
			-t "module" \
			has.cpp

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
