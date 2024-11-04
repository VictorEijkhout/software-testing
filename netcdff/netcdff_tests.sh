#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

##
## Tests
##

../existence_test.sh ${standardflags} \
		     --title "fortran module" \
		     --dir inc netcdf.mod

../cmake_test_driver.sh ${standardflags} \
			--title "compile with Fortran module (This test fails locally because libnetcdf and libnetcdff are not in the same directory)" \
			has.F90

../existence_test.sh ${standardflags} \
		     --title "config program" \
		     --dir bin nf-config

print_test_caption "nf-config libs option" "${logfile}"
export libline=$( nf-config --flibs | sed -e 's/^ *//' | sed -e 's/[ \t]+/ /g' )
echo "nf-config libline: <<$libline>>" >>${logfile}
export libdir=$( echo ${libline} | awk '{print $1}' | sed -e 's/-L//' )
echo "libdir: <<${libdir}>>" >>${logfile}
if [ ! -d ${libdir} ] ; then
    failure 1 "find nf-config lib dir <<${libdir}>>"
fi
nlibs=$( ls ${libdir}/*.so 2>/dev/null | wc -l )
if [ $nlibs -eq 0 ] ; then
    failure 1 "find libs in libdir <<${libdir}>>"
else 
    failure 0 "find libs in libdir <<${libdir}>>"
fi

if [ "${logfile}" = "compile.log" ] ; then
    echo "See: ${logfile}"
fi
