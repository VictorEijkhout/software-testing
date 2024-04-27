#!/bin/bash

package=netcdf
version=4.9.2
help_string="Loop over all compilers, testing one package version"

source ../options.sh

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "    testing ${package}/${version}"
echo "================"
echo 
logfile=tacc_tests.log
rm -f ${logfile}
for compiler in intel/19 intel/23 intel/24 gcc/9 gcc/11 gcc/12 gcc/13 ; do \
    retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... Unknown configuration ${compiler}" | tee -a ${logfile}
    else
	echo "==== Configuration: ${compiler}" | tee -a ${logfile}
	module load ${package}/${version} >>${logfile} 2>&1
	if [ $? -eq 0 ] ; then

	    source ${package}_tests.sh

	else
	    echo "WARNING could not load ${package}/${version}"
	fi
    fi
done
echo && echo "See: ${logfile}" && echo

