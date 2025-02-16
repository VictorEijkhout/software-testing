#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh \
    -p ${package} -l ${logfile} \
    --title "cmake binary" \
    --ldd \
    --dir bin cmake
