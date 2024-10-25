#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -m -p ${package} -l ${logfile} ${runflag} \
			--title "can we compile C" \
			has.c

../cmake_test_driver.sh -m -p ${package} -l ${logfile} ${runflag} \
			--title "can we compile Fortran" \
			fmod.F90

../cmake_test_driver.sh -m -p ${package} -l ${logfile} ${runflag} \
			--title "Fortran 2008 compatibility" \
			ph5example.F90
