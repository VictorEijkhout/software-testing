#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
	       --title "ldd on ALPS executable" \
	       --ldd -r \
	       --dir bin ALPS
