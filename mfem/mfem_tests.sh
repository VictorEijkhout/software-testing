#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--in-build-run \
			--title "can we compile and run" \
			ex0.cpp

echo "TEST ldd"
unresolved=$( ldd ${TACC_MFEM_LIB}/libmfem.so | grep "not found" | wc -l )
if [ ${unresolved} -gt 0 ] ; then
    us=$( u="" && for l in $( ldd ${TACC_MFEM_LIB}/libmfem.so | grep "not found" | awk '{print $1}' ) ; do u="$u $l"; done && echo $u )
    echo "ERROR unresolved libraries: ${us}"
fi
