#!/bin/bash

function usage () {
    echo "Usage: $0 [ -h ] [ -c compiler ]"
}

while [ $# -gt 0 ] ; do
    if [ $1 =  "-h" ] ; then
	usage && exit 0
    elif [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift
    else
	echo "Error: unrecognized option <<$1>>" && exit 1
    fi
done

source configurations.sh

for p in * ; do
    if [ -d "$p" -a -f "$p/package.sh" ] ; then
	pushd $p >/dev/null
	echo "---- $p"
	source package.sh
	list_configurations $package $version $compiler
	if [ $nconfigs -gt 0 ] ; then
	    echo " .. installed: ${configs}"
	else
	    echo " .. NOT installed"
	fi
	popd >/dev/null
    fi
done
