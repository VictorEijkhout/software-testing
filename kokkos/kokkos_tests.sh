#!/bin/bash

source ../test_setup.sh

##
## Tests
##

program=enabled-omp
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "testing ${program}" \
			${program}.cxx

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


