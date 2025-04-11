#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--in-build-run \
			--title "can we compile and run" \
			ex0.cpp

case ${version} in
    ( *cuda* )
    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			    --in-build-run --run-options "-pa -d cuda" \
			    --title "can we compile and run" \
			    ex1.cpp ;;
esac

../ldd_test.sh -p ${loadpackage} -l ${logfile} ${runflag} \
	       --title "ldd on libmfem.so" \
	       libmfem.so 
