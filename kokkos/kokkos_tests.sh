#!/bin/bash

##
## run tests, given a loaded compiler
##

source ../test_options.sh
source ../failure.sh

program=enabled-omp

echo "---- testing ${program}"
../cmake_test_driver.sh -p ${package} -l ${logfile} ${program}.cxx

# ${TACC_CXX} -I${TACC_KOKKOS_INC} -O2 -g  -std=c++17 -fopenmp -c ${program}.cxx \
#     >>${logfile} 2>&1 \
#     || retcode=$?
# failure $retcode "compilation"

# ${TACC_CXX} -o ${program} ${program}.o -fopenmp -lm -L${TACC_KOKKOS_LIB} -lkokkoscore\
#     >>${logfile} 2>&1 \
#     || retcode=$?
# failure $retcode "linking"

# ( ./${program} | grep "^Openmp" ) 2>/dev/null \
#     || retcode=$?
# failure $retcode "running"


