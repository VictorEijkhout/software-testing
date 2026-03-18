#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc finite-element.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "cmake config" \
		     --dir lib cmake/basix/BasixConfig.cmake

../existence_test.sh \
    -p ${package} -l ${logfile} \
    --title "shared library" \
    --ldd -r \
    --dir lib libbasix.so

