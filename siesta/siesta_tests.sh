#!/bin/bash

##
## run tests, given a loaded compiler
##

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "have main program" \
		     --dir bin siesta

if [ ! -z "${run}" ] ; then
    ( cd data/work && siesta < ../input.fdf )
fi
