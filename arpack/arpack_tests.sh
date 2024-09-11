#!/bin/bash

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header in arpack subdir" \
		     -d inc arpack/arpack.h

../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "can we compile Fortran" \
			dssimp.f

