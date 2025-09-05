#!/bin/bash

source ../test_setup.sh

##
## Tests
##

##
## C tests
##
# this uses pkg-config
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C" \
			hasc.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "are we threadsafe" \
			thread.c

##
## C++ tests
##
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C++ header" \
		     --dir inc H5Cpp.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C++ library" \
		     --dir lib libhdf5_cpp.so

# this uses find_package
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C++" \
			hascxx.cxx

##
## Fortran tests
##
# this uses find_package
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			fmod.F90

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "Fortran 2008 compatibility" \
			ph5example.F90
