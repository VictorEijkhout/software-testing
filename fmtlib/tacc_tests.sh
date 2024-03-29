#!/bin/bash

package=fmtlib
version=10.1.1

while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	echo "Usage: $0 [ -h ]" 
	echo "    [ -p package (default: ${package}) ]"
	echo "    [ -v version (default: ${version} ]"
	exit 1
    elif [ $1 = "-p" ] ; then
	shift && package=$1 && shift
    elif [ $1 = "-v" ] ; then 
	shift && version=$1 && shift
    fi
done

##
## test all programs for this package,
## looping over locally available modules
##

source ../options.sh

module reset >/dev/null 2>&1
echo "================"
echo "==== TACC modules"
echo "    testing ${package}/${version}"
echo "================"
echo 
logfile=tacc_tests.log
rm -f ${logfile}
for compiler in intel/19 intel/23 gcc/9 gcc/11 gcc/12 gcc/13 ; do \
    retcode=0 && module load ${compiler} >/dev/null 2>&1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo ".... Unknown configuration ${compiler}" | tee -a ${logfile}
    else
	echo "==== Configuration: ${compiler}" | tee -a ${logfile}
	module load ${package}/${version} >/dev/null 2>&1
	if [ $? -eq 0 ] ; then

	    source ${package}_tests.sh

	else
	    echo "WARNING could not load ${package}/${version}"
	fi
    fi
done
echo && echo "See: ${logfile}" && echo

