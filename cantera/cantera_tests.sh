#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} -r \
		     --ldd \
		     --title "random executable" \
		     --dir bin yaml2ck

../existence_test.sh -p ${package} -l ${logfile} -r \
		     --ldd \
		     --title "shared lib" \
		     --dir lib libcantera_shared.so

