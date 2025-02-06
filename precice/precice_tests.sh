#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header in include subdir" \
		     --dir inc precice/precice.hpp

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "so library" \
		     --ldd \
		     --dir lib libprecice.so


