#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc tsl/robin_map.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "cmake config" \
		     --dir dir share/cmake/tsl-robin-map/tsl-robin-mapConfig.cmake

# ../existence_test.sh \
#     -p ${package} -l ${logfile} \
#     --title "shared library" \
#     --ldd -r \
#     --dir lib libz.so

