#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc adios2.h

## the bin variable is not set
# ../existence_test.sh -p ${package} -l ${logfile} \
# 		     --title "config program" \
# 		     --dir bin adios2-config



