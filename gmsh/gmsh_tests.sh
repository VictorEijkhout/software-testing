#!/bin/bash

source ../test_setup.sh

##
## Tests
##

# can not run this without an input file
../existence_test.sh -p ${package} -l ${logfile} -r \
		     --ldd \
		     --title "gmsh executable" \
		     --dir bin gmsh

../existence_test.sh -p ${package} -l ${logfile} -r \
		     --title "gmsh lib" \
		     --dir lib libgmsh.so

../existence_test.sh -p ${package} -l ${logfile} -r \
		     --title "gmsh python api" \
		     --dir lib gmsh.py



