#!/bin/bash

##
## run tests, given a loaded compiler
##

command_args="$*"
source ./package.sh
source ../options.sh
source ../failure.sh

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile f90" \
			mpif90.F90

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile f08" \
			mpif08.F90

##
## this comes from the hdf5 test suite
##
# ../cmake_test_driver.sh -m -p ${package} -l ${logfile} ${runflag} \
# 			--title "overloaded allreduce" \
# 			-d hdf5 --cmake -DUSEHDF5=ON \
# 			hdf5async.F90
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "overloaded allreduce" \
			-d hdf5 --cmake -DUSEHDF5=ON \
			allreduce.F90

