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
		     --dir lib libz.a

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "shared library" \
		     --dir lib libz.so

