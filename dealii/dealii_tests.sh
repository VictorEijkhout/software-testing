#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-1" \
    step-1.cpp

# test for complex numbers
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-58" \
    step-58-complex.cpp

# test for hdf5 interface
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-62 uses hdf5" \
    step-62-hdf5.cpp

