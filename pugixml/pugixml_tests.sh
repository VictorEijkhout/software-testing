#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc pugixml.hpp

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "library" \
		     --ldd \
		     --dir lib libpugixml.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "pkg config" \
		     --dir lib pkgconfig/pugixml.pc

