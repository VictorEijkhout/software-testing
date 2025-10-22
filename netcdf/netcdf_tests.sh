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

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "fortran config program" \
		     --dir bin nf-config

../make_test_driver.sh ${standardflags} -l ${logfile} \
			--title "if we can compile with config" \
			sanity.cc

../make_test_driver.sh ${standardflags} -l ${logfile} \
			--title "if we can compile F90 with config" \
			simple_xy_wr.F90

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
