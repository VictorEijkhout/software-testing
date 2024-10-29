#!/bin/bash

##
## run tests, given a loaded environment
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

##
## Tests
##
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc fitsio.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header 2" \
		     --dir inc fitsio2.h



