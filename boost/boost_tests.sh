#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

../cmake_test_driver.sh ${standardflags} \
			--title "can we compile and run" \
			has.cpp

../cmake_test_driver.sh ${standardflags} \
			--title "file system" \
			system.cpp

../cmake_test_driver.sh ${standardflags} \
			--title "graph viz" \
			graphviz.cpp

../cmake_test_driver.sh ${standardflags} \
			--title "log" \
			log.cpp

echo "---- Test program_options"
found=$( find $TACC_BOOST_DIR -name \*.cmake | grep program_options | wc -l )
if [ ${found} -eq 0 ] ; then
    echo "FAILED to find cmake files"
else
    echo "     found"
fi

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
