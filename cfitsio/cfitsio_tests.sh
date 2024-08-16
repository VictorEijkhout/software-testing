#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     -d inc fitsio.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header 2" \
		     -d inc fitsio2.h



