#!/bin/bash

source ../test_setup.sh

##
## Tests
##

# this test is broken
../cmake_test_driver.sh ${standardflags} -l ${logfile} -r \
			--title "compile F scalapack (pkg-config)" \
			gridinit.F90

# do not run this example
../cmake_test_driver.sh ${standardflags} -l ${logfile} -r \
			--title "compile F scalapack (cmake find)" \
			gridinit.f90

