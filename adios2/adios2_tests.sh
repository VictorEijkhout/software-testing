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

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "config program" \
		     --dir bin adios2-config

../cmake_test_driver.sh ${standardflags} \
			--title "can we compile and run" \
			valuesWrite.cpp 
