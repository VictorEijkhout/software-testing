#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options/sh
source ../failure.sh

echo "Test if we can compile"
retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			create_open.c

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
