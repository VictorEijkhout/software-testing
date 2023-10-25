#!/bin/bash

program=enabled-gpu
retcode=0
module load cuda/12 kokkos/4.1.00-cuda || retcode=$?
if [ $retcode -gt 0 ] ; then
    echo "Could not load kokkos-cuda for this compiler" && exit 10
fi
source glibc_fix.sh
##echo ${LD_LIBRARY_PATH}

nvcc -I${TACC_KOKKOS_INC} -O2 -g  -std=c++17 --extended-lambda -arch=sm_75 -c ${program}.cu \
     || retcode=$?
if [ $retcode -gt 0 ] ; then
    echo "Compilation failure" && exit 11
fi
nvcc -ccbin g++ -o ${program} ${program}.o -lm -L${TACC_KOKKOS_LIB} -lkokkoscore \
     || retcode=$?
if [ $retcode -gt 0 ] ; then
    echo "Link failure" && exit 11
fi
./${program} \
     || retcode=$?
if [ $retcode -gt 0 ] ; then
    echo "Run failure" && exit 12
fi
  
