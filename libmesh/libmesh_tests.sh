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
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header in libmesh subdir" \
		     --dir inc libmesh/libmesh.h

../cmake_test_driver.sh ${standardflags} \
    --pkg-config "libmesh hdf5 petsc" \
    --title "compile ex1" \
    introduction_ex1.cxx

