#!/bin/bash

function usage () {
    echo "Usage: $0 [ -h ]"
    echo "    [ -c compiler (default: all compilers) ]"
    echo "    [ -f : skip fortran ] [ --small : no external package ]"
    echo "    [ -r : skip runs ] [ -t trace ]"
    echo "    [ -v baseversion (default: ${base}) ]"
}

base=$( make --no-print-directory version )
compiler=
docuda=
fortranflag=
runflag=
small=
trace=
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit 0
    elif [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift
    elif [ $1 = "-f" ] ; then
	shift && fortranflag=-r
    elif [ $1 = "-r" ] ; then
	shift && runflag=-r
    elif [ $1 = "--small" ] ; then
	shift && small=--small
    elif [ $1 = "-u" ] ; then
	shift && docuda=1
    elif [ $1 = "-t" ] ; then
	shift && trace=1
    elif [ $1 = "-v" ] ; then
	shift && base=$1 && shift
    else
	echo "ERROR unknown option <<$1>>" && exit 1
    fi
done

for variant in \
    $( cat test_versions.txt ) \
    ; do
    if [ "${variant}" = "vanilla" ] ; then
        version=${base}
    else
        version=${base}-${variant}
    fi
    echo "==== Testing version ${version}"
    ./tacc_tests.sh -v ${version} \
		    ${runflag} ${fortranflag} ${small} \
		    $( if [ ! -z "${docuda}" ] ; then echo "-u" ; fi ) \
		    $( if [ ! -z "${compiler}" ] ; then echo "-c ${compiler}" ; fi ) \
        | awk -v version=${version} '\
        /Configuration/ { configuration=$3 } \
        /^---- / { $1="" ; test=$0 } \
        /ERROR/ && configuration!="failed" { printf("Error: version <<%s>> configuration <<%s>> test <<%s>>\n",version,configuration,test) } \
	'
    cp petsc_logs/full.log ./${version}_tacc.log
done 2>&1 | tee all_tacc_tests.log

echo && echo "See: all_tacc_tests.log" && echo

