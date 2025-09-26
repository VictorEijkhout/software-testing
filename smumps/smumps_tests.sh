#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "settings file" \
		     --dir dir Makefile.inc

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "c single header" \
		     --dir inc smumps_c.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "c double header" \
		     --dir inc dmumps_c.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "c complex header" \
		     --dir inc cmumps_c.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "single lib" \
		     --ldd \
		     --dir lib libsmumps.so

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "double lib" \
		     --ldd \
		     --dir lib libdmumps.so
