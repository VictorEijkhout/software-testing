#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

##
## Tests
##
../cmake_test_driver.sh ${standardflags} \
			--title "can we compile C" \
			has.c

../cmake_test_driver.sh ${standardflags} \
			--title "can we run C" \
			dataset.c

../cmake_test_driver.sh ${standardflags} \
			--title "can we compile C++" \
			hasx.cxx

../cmake_test_driver.sh ${standardflags} \
			--title "can we compile Fortran" \
			fmod.F90
