#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc zlib.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "static library" \
		     --dir lib -r libz.a

../existence_test.sh \
    -p ${package} -l ${logfile} \
    --title "shared library" \
    --ldd -r \
    --dir lib libz.so

