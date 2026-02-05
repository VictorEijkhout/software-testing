#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C" \
    --cmake "-DHYPRE_INCLUDE_DIRS=${TACC_HYPRE_INC},-DHYPRE_LIBRARY_DIRS=${TACC_HYPRE_LIB},-DHYPRE_LIBRARIES=libHYPRE.so" \
    has.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
    --cmake "-DHYPRE_INCLUDE_DIRS=${TACC_HYPRE_INC},-DHYPRE_LIBRARY_DIRS=${TACC_HYPRE_LIB},-DHYPRE_LIBRARIES=libHYPRE.so" \
    ex5f.f
