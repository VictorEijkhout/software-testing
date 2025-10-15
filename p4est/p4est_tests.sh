#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    --title "if we can compile" \
    has.c

# note: ldd test does not work on cmake driver, only on existence test
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    --ldd \
    --title "example from src trree" \
    simple2.c

# cpp is really C, but uses find_package instead of pkg_config
../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    --title "if we can compile" \
    has.cpp

