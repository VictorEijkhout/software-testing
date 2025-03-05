#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "random executable" \
		     --dir bin gbase

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "c header" \
		     --dir inc scotch.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "f header" \
		     --dir inc scotchf.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "lib" \
		     --dir lib libscotch.so

