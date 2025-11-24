#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    --title "point functions cxx" \
    --cmake -DSILO_INC=${TACC_SILO_INC},-DSILO_LIB=${TACC_SILO_LIB},-DCMAKE_EXE_LINKER_FLAGS=-lpthread \
    point.cxx

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    --title "point functions c" \
    --cmake -DSILO_INC=${TACC_SILO_INC},-DSILO_LIB=${TACC_SILO_LIB},-DCMAKE_EXE_LINKER_FLAGS=-lpthread \
    point.c

