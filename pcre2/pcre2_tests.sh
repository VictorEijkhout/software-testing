#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir lib libpcre2-8.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     cmake/pcre2-config.cmake
