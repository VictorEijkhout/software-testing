#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc adios2.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "config program" \
		     --dir bin adios2-config

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "can we compile and run" \
			valuesWrite.cpp 

## https://github.com/ornladios/ADIOS2/issues/4585
# ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
# 			--title "can we compile and run Fortran" \
# 			values.F90
