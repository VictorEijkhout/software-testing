#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "python package" \
		     --dir dir nanobind/__init__.py

# ../existence_test.sh \
#     -p ${package} -l ${logfile} \
#     --title "shared library" \
#     --ldd -r \
#     --dir lib libz.so

