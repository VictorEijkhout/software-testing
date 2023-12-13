#!/bin/bash
################################################################
####
#### Example tutorial file
####
#### build.sh : driver for swig usage
####
################################################################
module load python3/3.9

swig -python example.i
${TACC_CC} -c example.c example_wrap.c \
    -g -fPIC \
    -I${TACC_PYTHON_INC}/python3.9
ld -shared example.o example_wrap.o -o _example.so 
