#!/bin/bash

function usage () {
    echo "Usage: $0 [ -j 123 ] [ -c compiler ] [ -t target ] [ -v version ]"
    echo "    [ -x ] [ package ]"
    echo "    -t : make target or default_install"
    echo "    -v : package version"
    echo "    (package: explicit, or current directory)"
}

compilerselect=
jcount=4
modules=
target=default_install
version=
setx=
while [ $# -gt 0 ] ; do
    if [ "$1" = "-j" ] ; then 
	shift && jcount=$1 && shift
    elif [ "$1" = "-c" ] ; then
	shift && compilerselect="$1" && shift
    elif [ "$1" = "-t" ] ; then
	shift && target=$1 && shift
    elif [ "$1" = "-v" ] ; then
	shift && version=$1 && shift
    elif [ "$1" = "-x" ] ; then
	shift && setx=1
    elif [[ $1 = \-* ]] ; then
	echo "Unknown option <<$1>>" && usage && exit 1
    else
	break
    fi
done

##
## go to package directory
##
if [ $# -gt 0 ] ; then
    package=$1
else
    package=${PWD} && package=${package##*/}
fi
cd ${HOME}/Testing
if [ ! -d "$package" ] ; then
    echo "No such package: <<$package>>" && exit 1
fi
echo -e "\nTesting package: $package\n"
cd $package
mpm.py clean

##
## find compilers to use
##
compilersfile=${HOME}/Testing/compilers_${TACC_SYSTEM}.sh
if [ ! -f "$compilersfile" ] ; then
    echo "Could not find compilersfile: $compilersfile" && exit 1
fi
compilers="$( cat $compilersfile )"
echo "Going to test <<$package>> for compilers: <<$compilers>>"

##
## do install for all compilers
##
for compiler in $compilers ; do

    ##
    ## Split compiler into usepath / compiler
    ##
    usepath=${compiler%%:*}
    if [ ! -z "${usepath}" ] ; then
	module use "${usepath}"
    fi
    compiler="${compiler##*:}"

    ##
    ## skip if we explicitly requested a compiler
    ##
    if [ ! -z "$compilerselect" ] ; then
	if [[ $compiler != ${compilerselect}* ]] ; then
	       echo "Compiler <<$compiler>> does not match selected compiler <<$compilerselect>>"
	       continue
	   fi
    fi

    ##
    ## Reset modules and load compiler
    ##
    module purge 2>/dev/null
    module reset 2/dev/null
    if [ ! -z "${set}" ] ; then set -x ; fi
    module -t load ${compiler} 2>/dev/null
    if [ $? -gt 0 ] ; then
	echo "Could not load compiler ${compiler}"
	if [ ! -z "${usepath}" ] ; then echo " .. along path ${usepath}" ; fi
	continue
    else
	echo "================================================================"
	echo "================ Compiler: ${compiler} ================"
	echo "================================================================"
    fi
    
    ##
    ## Load package
    ##
    module -t load ${package} 2>/dev/null
    if [ $? -gt 0 ] ; then
	echo "FAILURE: Could not load ${package} for ${compiler}"
	continue
    fi
    compilerlog="${package}_$( echo ${compiler} | tr -d '/' ).log"
    module -t list    >"${compilerlog}" 2>&1

    ##
    ## And go!
    ##
    mpm.py regression >"${compilerlog}" 2>&1
    if [ $( grep FAILURE "${compilerlog}" | wc -l ) -gt 0 ] ; then
	grep FAILURE "${compilerlog}"
    else
	echo SUCCESS
    fi

done 2>&1 | tee ${package}_all.log

