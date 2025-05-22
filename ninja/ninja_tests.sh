#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

# we can't run without actual build.ninja input file
../existence_test.sh -p ${package} -l ${logfile} -r \
		     --title "base executable" \
		     --ldd \
		     --dir bin ninja

