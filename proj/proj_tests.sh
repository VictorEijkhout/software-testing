#!/bin/bash

source ../test_setup.sh

##
## Tests
##

## ../cmake_test_driver.sh ${standardflags} -l ${logfile} 
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir lib libproj.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --ldd \
		     --dir bin proj
