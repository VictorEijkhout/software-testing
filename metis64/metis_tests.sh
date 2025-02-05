#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc metis.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "library" \
		     --dir lib libmetis.so

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                        -t 1 \
			--title "can we compile C" \
			has.c

