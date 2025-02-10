#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc sz/sz_api.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "lowcase library" \
		     --dir lib libsz.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "upcase library" \
		     --dir lib libSZ.so

