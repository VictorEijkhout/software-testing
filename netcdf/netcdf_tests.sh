#!/bin/bash

##
## run tests, given a loaded compiler
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

##echo "Test if we can compile"
retcode=0
../cmake_test_driver.sh -p ${package} -l ${logfile} ${runflag} \
			--title "if we can compile" \
			sanity.c

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "config program" \
		     --dir bin nc-config


if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
