#!/bin/bash

source ../test_setup.sh

##
## Tests
##

## ../cmake_test_driver.sh ${standardflags} -l ${logfile} 
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "shared lib" \
		     --dir lib libpgplot.so
