#!/bin/bash

set -x
module load intel
for compiler in ifx ifort ; do
    ${compiler} dealloc.F90  && ./a.out
done
module load gcc
for compiler in gfortran ; do
    ${compiler} dealloc.F90  && ./a.out
done
