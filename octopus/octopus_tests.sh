#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "executable" \
		     --dir dir bin/octopus

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "parse header" \
		     --dir inc liboct_parser.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "static lib" \
		     --dir lib liboctopus.a

