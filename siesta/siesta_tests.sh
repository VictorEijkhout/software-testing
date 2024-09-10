#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

if [ -d "${TACC_SIESTA_DIR}/bin" ] ; then
    echo "     has bin"
else
    failure 1 "bin directory not found"
fi


# ../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
# 			--title "can we compile and run" \
# 			has.c 

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
