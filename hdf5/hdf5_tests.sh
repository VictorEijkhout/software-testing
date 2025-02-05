#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C" \
			has.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we run C" \
			dataset.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile C++" \
			hasx.cxx

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile Fortran" \
			fmod.F90
