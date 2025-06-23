#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc gmp.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "dynamic lib" \
		     --ldd -r \
		     --dir lib libgmp.so
