#!/bin/bash

source ../test_setup.sh

##
## Tests
##

# https://github.com/geodynamics/aspect/issues/6716
# ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
# 			--title "example: first" \
# 			first.cpp

LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${TACC_ASPECT_DIR}/bin \
	       aspect-release --test
