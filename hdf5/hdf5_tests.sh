#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C" \
			has.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "are we threadsafe" \
			thread.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we run C" \
			dataset.c

##
## C++ tests
##
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C++ header" \
		     --dir inc H5Cpp.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "C++ library" \
		     --dir lib libhdf5_cpp.so

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C++" \
			hasx.cxx

##
## Fortran tests
##
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			fmod.F90
