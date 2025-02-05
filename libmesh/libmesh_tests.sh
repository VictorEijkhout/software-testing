#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header in libmesh subdir" \
		     --dir inc libmesh/libmesh.h

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    --pkg-config "libmesh hdf5 petsc" \
    --title "compile ex1" \
    introduction_ex1.cxx

