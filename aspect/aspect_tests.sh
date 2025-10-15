#!/bin/bash

source ../test_setup.sh

##
## Tests
##

# https://github.com/geodynamics/aspect/issues/6716
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "example: first" \
			first.cpp
