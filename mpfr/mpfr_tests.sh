#!/bin/bash

##
## run tests, given a loaded compiler
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
		     --dir inc mpfr.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "lib" \
		     --dir lib libmpfr.so

