#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-1" \
    step-1.cpp

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-58" \
    step-58.cpp
