#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--in-build-run \
			--title "can we compile and run" \
			ex0.cpp

../ldd_test.sh -p ${loadpackage} -l ${logfile} ${runflag} \
	       --title "ldd on libmfem.so" \
	       libmfem.so 
