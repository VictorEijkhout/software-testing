#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C" \
			has.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			fmod.F90

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "Fortran 2008 compatibility" \
			ph5example.F90
