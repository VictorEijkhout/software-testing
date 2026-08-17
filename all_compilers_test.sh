#!/bin/bash

################################################################
####
#### Test one package with all available compiers.
#### This should be invoken from inside a package directory.
####
################################################################

function usage () {
    echo "Usage: $0 [ -h] [ -c Configuration ]"
    echo "    [ --intel/gcc : intel or gcc only ]"
    echo "    [ --norun ] [ --test mpmflags ]"
}

configuration=Configuration
compilers="gcc intel"
testflags=
norun=
while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-c" ] ; then
	shift && configuration="$1" && shift
    elif [ "$1" = "--gcc" ] ; then
	shift && compilers=gcc
    elif [ "$1" = "--intel" ] ; then
	shift && compilers=intel
    elif [ "$1" == "--norun" ] ; then
	norun=1 && shift
    elif [ "$1" = "--test" ] ; then
	shift && testflags="$1" ; shift
    else
	echo "Unknown option <<$1>>" && exit 1
    fi
done

if [ ! -f "${configuration}" ] ; then
    echo "ERROR Could not find configuration file <<$configuration>>"
    usage && exit 1
fi

alltestslog=${PWD}/all_tests.log
compilers=$( module -t avail ${compilers} 2>&1 | grep -v ':' | grep -v '/.*/' )
if [ -z "${compilers}" ] ; then
    echo "Error: no compilers available"
    exit 1
fi

echo -e "\nTesting $( mpm.py package ) on the following compilers:"
echo    "${compilers}"
if [ ! -z "${testflags}" ] ; then
    echo " .. applying flags: ${testflags}"
fi
echo    "See output in ${alltestslog}"
if [ ! -z "${norun}" ] ; then
    exit 0
fi

for compiler in ${compilers} ; do
    echo -e "\nTesting compiler: $compiler\n"
    module -t load "${compiler}" >/dev/null 2>&1
    SCRIPTSDIR="mpm_scripts_$( echo ${compiler} | tr -d '/' )" \
	      mpm.py -c "${configuration}" ${testflags} clean regression
done 2>&1 | tee ${alltestslog}
