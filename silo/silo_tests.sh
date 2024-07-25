#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

echo "---- Test point functions"
set -x
../cmake_test_driver.sh \
    --cmake -DSILO_INC=${TACC_SILO_INC},-DSILO_LIB=${TACC_SILO_LIB} \
    -l ${logfile} \
    point.c

