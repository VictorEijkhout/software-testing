#!/bin/bash
################################################################
####
#### Example tutorial file
####
#### build.sh : driver for swig usage
####
################################################################
module load python3/3.9

if [ -z "${TACC_CC}" ] ; then
    echo "Set variable TACC_CC" && exit 1
fi

swig -python example.i
${TACC_CC} -c example.c example_wrap.c \
    -g -fPIC \
    -I${TACC_PYTHON_INC}/python3.9
ld -shared example.o example_wrap.o -o _example.so 
