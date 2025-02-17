#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir inc sqlite3.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "dynamic lib" \
		     --ldd -r \
		     --dir lib libsqlite3.so
