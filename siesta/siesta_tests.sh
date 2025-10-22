#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "have main program" \
		     --ldd --run_args -h \
		     --dir bin siesta

##
## non-functioning test
## forrtl: severe (174): SIGSEGV, segmentation fault occurred
##

# if [ ! -z "${run}" ] ; then
#     runtimeerror=
#     ( cd data/work && ibrun -np 1 siesta < ../input.fdf >unittest_log 2>&1 ) || runtimeerror=1
#     if [ ! -z "${runtimeerror}" ] ; then
# 	echo "ERROR runtime error"
#     fi
# fi
