#!/bin/bash

source ../test_setup.sh

##
## Tests
##

##
## C tests
##
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C" \
			has.c

##
## C++ tests
##
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C++ header" \
		     --dir inc H5Cpp.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C++ library" \
		     --dir lib libhdf5_cpp.so

##
## Fortran tests
##
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			fmod.F90

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "Fortran 2008 compatibility" \
			ph5example.F90
