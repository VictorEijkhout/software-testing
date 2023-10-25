#!/bin/bash

if [ -z ${compilelog} ] ; then
    compilelog=compile.og
fi
program=enabled-omp
module=kokkos/4.1.00-omp

source ../failure.sh

retcode=0
module load ${module} || retcode=$?
failure $retcode "loading module ${module}"

echo "---- testing ${program}"
${TACC_CXX} -I${TACC_KOKKOS_INC} -O2 -g  -std=c++17 -fopenmp -c ${program}.cxx \
    >>${compilelog} 2>&1 \
    || retcode=$?
failure $retcode "compilation"

${TACC_CXX} -o ${program} ${program}.o -fopenmp -lm -L${TACC_KOKKOS_LIB} -lkokkoscore\
    >>${compilelog} 2>&1 \
    || retcode=$?
failure $retcode "linking"

( ./${program} | grep "^Openmp" ) 2>/dev/null \
    || retcode=$?
failure $retcode "running"


