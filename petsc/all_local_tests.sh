#!/bin/bash

function usage () {
    echo "Usage: $0 [ -h ]"
    echo "    [ -c compiler (default: all compilers) ]"
    echo "    [ -r : skip runs ]"
echo "    [ -v baseversion (default: ${base}) ]"
}

base=$( make --no-print-directory version )
compiler=
runflag=
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit 0
    elif [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift
    elif [ $1 = "-r" ] ; then
	shift && runflag=-r
    elif [ $1 = "-v" ] ; then
	shift && base=$1 && shift
    fi
done
# "" debug complex i64 complexi64 complexsingle f08 single nohdf5 \
#
fulllog=all_local_tests.log
for variant in \
    $( cat ../../Software/petsc/test_versions.txt ) \
    ; do
    if [ "${variant}" = "vanilla" ] ; then
        version=${base}
    else
        version=${base}-${variant}
    fi
    echo "==== Testing version ${version}"
    ./local_tests.sh -v ${version} \
		    ${runflag} \
		    $( if [ ! -z "${compiler}" ] ; then echo "-c ${compiler}" ; fi ) \
        | awk -v version=${version} '\
        /Configuration/ { configuration=$3 } \
	/^---- / { $1="" ; test=$0 } \
	/ERROR/ { printf("Error: version <<%s>> configuration <<%s>> test <<%s>>\n",version,configuration,test) } \
	'
done
