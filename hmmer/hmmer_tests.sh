#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh \
    -p ${package} -l ${logfile} \
    --title "hmmsearch binary" \
    --ldd \
    --dir bin hmmsearch
