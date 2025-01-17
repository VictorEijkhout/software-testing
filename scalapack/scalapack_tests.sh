#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

# do not run this example
../cmake_test_driver.sh -m -p ${package} -l ${logfile} -r \
			--title "compile F scalapack" \
			gridinit.F90

