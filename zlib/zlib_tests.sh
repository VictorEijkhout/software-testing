#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     -d inc zlib.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "static library" \
		     -d lib libz.a

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "shared library" \
		     -d lib libz.so

