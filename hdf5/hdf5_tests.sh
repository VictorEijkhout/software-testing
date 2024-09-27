#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../cmake_test_driver.sh -l ${logfile} ${runflag} \
			--title "can we compile C" \
			has.c

../cmake_test_driver.sh -l ${logfile} ${runflag} \
			--title "can we run C" \
			dataset.c

../cmake_test_driver.sh -l ${logfile} ${runflag} \
			--title "can we compile C++" \
			hasx.cxx

../cmake_test_driver.sh -l ${logfile} ${runflag} \
			--title "can we compile Fortran" \
			fmod.F90
