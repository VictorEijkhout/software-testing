#!/bin/bash

################################################################
####
#### Test one package with all available compiers.
#### This should be invoken from inside a package directory.
####
################################################################

function usage () {
    echo "Usage: $0 [ -h] [ -c Configuration ] [ --intel/gcc : intel or gcc only ]"
}

configuration=Configuration
compilers="gcc intel"
while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-c" ] ; then
	shift && configuration="$1" && shift
    elif [ "$1" = "--gcc" ] ; then
	shift && compilers=gcc
    elif [ "$1" = "--intel" ] ; then
	shift && compilers=intel
    else
	echo "Unknown option <<$1>>" && exit 1
    fi
done

if [ ! -f "${configuration}" ] ; then
    echo "ERROR Could not find configuration file <<$configuration>>"
    usage && exit 1
fi

for compiler in $( module -t avail ${compilers} 2>&1 | grep -v ":" ) ; do
    echo -e "\nTesting compiler: $compiler\n"
    module -t load "${compiler}" >/dev/null 2>&1
    SCRIPTSDIR="mpm_scripts_$( echo ${compiler} | tr -d '/' )" \
	      mpm.py -c "${configuration}" clean regression
done
