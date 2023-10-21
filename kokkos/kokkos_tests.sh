#!/bin/bash

module unload cuda
module load cuda/12 kokkos/4.1.00
source glibc_fix.sh
echo ${LD_LIBRARY_PATH}

if [ -z "${TACC_CXX}" ] ; then
    echo "ERROR set TACC_CXX" && exit 1
fi

${TACC_CXX} -I${TACC_KOKKOS_INC} -O2 -g  -std=c++17 -fopenmp -c enabled-omp.cxx
${TACC_CXX} -o enabled-omp enabled-omp.o -fopenmp -lm -L${TACC_KOKKOS_LIB} -lkokkoscore
./enabled-omp

program=enabled-gpu
module load cuda/12 kokkos/4.1.00-cuda
source glibc_fix.sh
echo ${LD_LIBRARY_PATH}

nvcc -I${TACC_KOKKOS_INC} -O2 -g  -std=c++17 --extended-lambda -arch=sm_75 -c ${program}.cu
nvcc -ccbin g++ -o ${program} ${program}.o -lm -L${TACC_KOKKOS_LIB} -lkokkoscore
./${program}
