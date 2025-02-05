#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc fitsio.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header 2" \
		     --dir inc fitsio2.h



