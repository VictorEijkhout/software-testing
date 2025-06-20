#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile F lapack95" \
			lapack95.F90

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "siesta return convention" \
			convention.F90

