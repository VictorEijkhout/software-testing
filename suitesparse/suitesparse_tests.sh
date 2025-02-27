#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc suitesparse/GraphBLAS.h

../existence_test.sh -p ${package} -l ${logfile} \
    --title "mongoose" \
    --ldd -r \
    --dir bin suitesparse_mongoose

