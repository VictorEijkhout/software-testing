#!/bin/bash

source ../test_setup.sh

##
## Tests
##

# do not run this example
../cmake_test_driver.sh ${standardflags} -l ${logfile} -r \
			--title "compile F scalapack" \
			gridinit.F90

