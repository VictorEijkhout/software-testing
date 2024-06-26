#!/bin/bash

package=petsc

##
## cycle over all available versions
## maybe limited by compiler
##

##
## maybe get custom version and compiler
##
matchversion=3.21
compiler=

function usage() {
    echo "Usage: $0 [ -v matchedversion (default=${matchversion}) ]"
    echo "    [ -c compiler ] [ -b (skip ibrun) ]"
    if [ ! -z "${extra_help}" ] ; then echo ${extra_help} ; fi
}
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0
fi
noibrun=
while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-b" ] ; then
	noibrun="-b" && shift
    elif [ "$1" = "-c" ] ; then
	shift && compiler="$1" && shift
    elif [ "$1" = "-v" ] ; then
	shift && matchversion="$1" && shift
    fi
done


alllog=all_local_tests.log
versions=$( module -t avail ${package} 2>&1 | sed -e '1d' )
for version in ${versions} ; do
    version=${version##${package}/}
    if [[ ${version} = *${matchversion}* ]] ; then 
	echo "Testing package version <<$package/$version>>"
	./local_tests.sh -v $version ${noibrun} \
	    $( if [ ! -z "${compiler}" ] ; then echo "-c $compiler" ; fi )
    else
	echo "Version skipped: <<$version>>"
    fi 
done 2>&1 | tee ${alllog}
echo && echo "See: ${alllog}" && echo 
