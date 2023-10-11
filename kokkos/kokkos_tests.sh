#!/bin/bash

module unload cuda
module load kokkos/4.1.00
source glibc_fix.sh
echo ${LD_LIBRARY_PATH}

g++ -I${TACC_KOKKOS_INC} -O2 -g  -fopenmp -c enabled-omp.cxx
g++ -o enabled-omp enabled-omp.o -fopenmp -lm -L${TACC_KOKKOS_LIB} -lkokkoscore
./enabled-omp

program=enabled-gpu
module load cuda/12 kokkos/4.1.00-cuda
source glibc_fix.sh
echo ${LD_LIBRARY_PATH}

nvcc -I${TACC_KOKKOS_INC} -O2 -g --extended-lambda -arch=sm_75 -c enabled-gpu.cu
nvcc -ccbin g++ -o enabled-gpu enabled-gpu.o -lm -L${TACC_KOKKOS_LIB} -lkokkoscore
./enabled-gpu
