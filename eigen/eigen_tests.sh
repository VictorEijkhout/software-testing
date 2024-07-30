#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "compile and run with pkgconfig" \
			-t "package" \
			has.cxx 

retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} \
			--title "compile and run with find_package" \
			-t "module" \
			has.cpp

testcaption="contents of INC dir"
echo "---- Test: ${testcaption}"
if [ -d "${TACC_EIGEN_INC}/Eigen" ] ; then
    echo "     has"
else
    failure 1 "not finding TACC_EIGEN_INC/Eigen=${TACC_EIGEN_INC}/Eigen"
fi

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
