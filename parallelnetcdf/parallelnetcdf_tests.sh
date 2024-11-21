#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

../cmake_test_driver.sh ${standardflags} \
			--title "can we compile parallel C" \
			parallel_vara.c

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "config program" \
		     --dir bin nc-config

