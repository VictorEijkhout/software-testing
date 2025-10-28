#!/bin/bash

source ../test_setup.sh

##
## Tests
##

# can not run this without an input file
../existence_test.sh -p ${package} -l ${logfile} -r \
		     --ldd \
		     --title "random executable" \
		     --dir bin gdalinfo

