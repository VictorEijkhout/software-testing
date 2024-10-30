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
			--title "can we compile Fortran" \
			fmod.F90

../cmake_test_driver.sh ${standardflags} \
			--title "Fortran 2008 compatibility" \
			ph5example.F90
