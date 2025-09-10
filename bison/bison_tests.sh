#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh \
    -p ${package} -l ${logfile} \
    --title "bison binary" \
    --ldd \
    --run_args "-h" \
    --dir bin bison
