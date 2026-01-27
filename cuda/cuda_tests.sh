#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../make_test_driver.sh ${standardflags} -l ${logfile} \
			--title "empty program" \
			config.cu

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "device detection" \
			device.cu

