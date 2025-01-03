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
		     --title "header in libmesh subdir" \
		     --dir inc libmesh/libmesh.h

