#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     -d inc adios2.h

## the bin variable is not set
# ../existence_test.sh -p ${package} -l ${logfile} \
# 		     --title "config program" \
# 		     -d bin adios2-config



