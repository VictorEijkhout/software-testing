#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

# do not run, to prevent message about input files
../existence_test.sh -p ${package} -l ${logfile} \
		     --ldd -r \
		     --title "base executable" \
		     --dir bin swig

