#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			--title "if we can compile" \
			sanity.c

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "config program" \
		     --dir bin nc-config

echo "---- Test: nc-config libdir"
if [ -d $( nc-config --libdir ) ] ; then
    echo "     nc-config correctly reports lib"
else
    echo "ERROR nc-config libdir does not exist"
fi

echo "---- Test: nc-config includedir"
if [ -d $( nc-config --includedir ) ] ; then
    echo "     nc-config correctly reports include"
else
    echo "ERROR nc-config includedir does not exist"
fi

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
