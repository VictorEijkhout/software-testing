#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc ufcx.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "pkgconfig" \
		     --dir dir share/pkgconfig/ufcx.pc

