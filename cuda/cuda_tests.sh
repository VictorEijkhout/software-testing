#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "device detection" \
			device.cu

../make_test_driver.sh ${standardflags} -l ${logfile} \
			--title "empty program" \
			config.cu

