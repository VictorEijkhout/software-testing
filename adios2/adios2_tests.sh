#!/bin/bash

##
## run tests, given a loaded environment
##

source ./package.sh

command_args=$*
source ../options.sh

set_flags

source ../failure.sh

##
## Tests
##
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc adios2.h

## the bin variable is not set
# ../existence_test.sh -p ${package} -l ${logfile} \
# 		     --title "config program" \
# 		     --dir bin adios2-config



