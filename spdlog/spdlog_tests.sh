#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc spdlog/spdlog.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "library" \
		     --ldd \
		     --dir lib libspdlog.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "pkg config" \
		     --dir lib pkgconfig/spdlog.pc

