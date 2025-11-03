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
			--title "step-58 uses complex" \
    step-58-complex.cpp

# test for hdf5 interface
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-62 uses real hdf5" \
    step-62-hdf5.cpp

# test for hdf5 & complex pesc interface
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-62 uses complex petsc" \
    step-62-complex-petsc.cpp

# test for petsc interface
# this example is explicit for real petsc
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "step-86 uses real petsc" \
    step-86-petsc.cpp

