#!/bin/bash

source ../test_setup.sh

##
## Tests
##

## ../cmake_test_driver.sh ${standardflags} -l ${logfile} 
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir inc sqlite3.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "dynamic lib" \
		     --ldd \
		     --dir lib libsqlite3.so
