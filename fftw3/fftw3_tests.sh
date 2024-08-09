#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "can we compile and run" \
			has.c 

../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "can we single precision" \
			single.c 

if [ ! -f ${TACC_FFTW3_LIB}/libfftw3.so ] ; then
    failure 1 "No double precision library"
fi

if [ ! -f ${TACC_FFTW3_LIB}/libfftw3f.so ] ; then
    failure 1 "No single precision library"
fi

##echo "--- Test if we can compile and run"
# doesn't work yet
# ../cmake_test_driver.sh -p ${package} -l ${logfile} \
# 			--title "cmake module" \
# 			has.cxx


if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
