#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "yaml.h header" \
		     --dir inc yaml-cpp/yaml.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "yaml.so lib" \
		     --ldd \
		     --dir lib libyaml-cpp.so

