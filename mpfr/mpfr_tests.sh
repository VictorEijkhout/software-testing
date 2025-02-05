#!/bin/bash

source ../test_setup.sh

##
## Tests
##

## ../cmake_test_driver.sh ${standardflags} -l ${logfile} 
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc mpfr.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "lib" \
		     --dir lib libmpfr.so

