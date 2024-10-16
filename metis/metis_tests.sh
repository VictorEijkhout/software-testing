#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     -d inc metis.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "library" \
		     -d lib libmetis.so

../cmake_test_driver.sh -m -p ${package} -l ${logfile} ${runflag} \
                        -t 1 \
			--title "can we compile C" \
			has.c

