#!/bin/bash

program=enabled-gpu
module load cuda/12 kokkos/4.1.00-cuda
nvcc -I${TACC_KOKKOS_INC} -O2 -g --extended-lambda -arch=sm_75 -c enabled-gpu.cu
nvcc -ccbin g++ -o enabled-gpu enabled-gpu.o -lm -L${TACC_KOKKOS_LIB} -lkokkoscore
