#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../test_options.sh
source ../failure.sh

##echo "---- Test if we can compile C"
../cmake_test_driver.sh -l ${logfile} \
			--title "---- if we can compile C" \
			has.c

##echo "---- Test if we can run C"
../cmake_test_driver.sh -l ${logfile} \
			--title "---- if we can run C" \
			dataset.c

##echo "---- Test if we can compile C++"
../cmake_test_driver.sh -l ${logfile} \
			--title "---- if we can compile C++" \
			hasx.cxx

##echo "---- Test if we can compile Fortran"
../cmake_test_driver.sh -l ${logfile} \
			--title "---- if we can compile Fortran" \
			fmod.F90
