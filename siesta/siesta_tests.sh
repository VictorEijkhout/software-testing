#!/bin/bash

##
## run tests, given a loaded compiler
##

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "have main program" \
		     --ldd --run_args --help \
		     --dir bin siesta

# if [ ! -z "${run}" ] ; then
#     runtimeerror=
#     ( cd data/work && siesta < ../input.fdf >/dev/null 2>&1 ) || runtimeerror=1
#     if [ ! -z "${runtimeerror}" ] ; then
# 	echo "ERROR runtime error"
#     fi
# fi
