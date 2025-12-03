#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile c" \
			mpi.c

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile c++" \
			mpi.cxx

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile f90" \
			mpif90.F90

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "compile f08" \
			mpif08.F90

##
## do we have all names?
## this tests a bug in intel 2024.{1,2} Not zero! Fixed in 2025.
## But we should really extend this.
##
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "names for c" \
			names.c

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

