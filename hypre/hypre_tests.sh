#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

echo "---- Test if we can compile"
../cmake_test_driver.sh -m -p ${package} -l ${logfile} \
    --cmake "-DHYPRE_INCLUDE_DIRS=${TACC_HYPRE_INC},-DHYPRE_LIBRARY_DIRS=${TACC_HYPRE_LIB},-DHYPRE_LIBRARIES=libHYPRE.so" \
    has.c
