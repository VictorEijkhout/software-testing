#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

# echo "Test if we can compile C"
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header in arpack subdir" \
		     -d inc arpack/arpack.h

##echo "if we can compile Fortran"
../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "if we can compile Fortran" \
			dssimp.f

