#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
    --title "point functions cxx" \
    --cmake -DSILO_INC=${TACC_SILO_INC},-DSILO_LIB=${TACC_SILO_LIB} \
    point.cxx

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
    --title "point functions c" \
    --cmake -DSILO_INC=${TACC_SILO_INC},-DSILO_LIB=${TACC_SILO_LIB} \
    point.c

