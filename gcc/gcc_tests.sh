#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --ldd -r \
		     --title "C compiler" \
		     --dir bin var=TACC_CC

../existence_test.sh -p ${package} -l ${logfile} \
		     --ldd -r \
		     --title "C++ compiler" \
		     --dir bin var=TACC_CXX

../existence_test.sh -p ${package} -l ${logfile} \
		     --ldd -r \
		     --title "Fortran compiler" \
		     --dir bin var=TACC_FC
