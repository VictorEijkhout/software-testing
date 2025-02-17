#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
    --title "core header" \
    --ldd -r \
    --dir lib libpcre2-8.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     cmake/pcre2-config.cmake

