#!/bin/bash

source ../test_setup.sh

##
## Tests
##

## ../cmake_test_driver.sh ${standardflags} -l ${logfile} 
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "omp lib" \
		     --dir lib libginkgo_omp.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "inc file" \
		     --dir inc ginkgo/ginkgo.hpp
