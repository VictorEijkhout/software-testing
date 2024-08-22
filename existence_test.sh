#!/bin/bash

##
## Driver for cmake_build_single.sh
##

defaultp=$( pwd )
defaultp=${defaultp##*/}

function usage() {
    echo "Usage: $0"
    echo "    [ -d dir (dir/lib/inc) ] "
    echo "    [ -p package (default: ${defaultp}) ]  [ -l logfile ]"
    echo "    [ --title test caption ]"
    echo "    dir/inc/lib file"
}

## echo "Invocation: $*"
if [ $# -eq 0 -o $1 = "-h" ] ; then 
    usage && exit 0
fi

source ../failure.sh
package=unknown
fulllog=
testcaption=
dir=dir
while [ $# -gt 2 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && exit 0
    elif [ "$1" = "-d" ] ; then 
	shift && dir="$1" && shift
    elif [ "$1" = "-l" ] ; then 
	shift && fulllog="$1" && shift
    elif [ "$1" = "-p" ] ; then 
	shift && package="$1" && shift
    elif [ "$1" = "--title" ] ; then
	shift && testcaption="$1" && shift
    else
	break
    fi
done

##
## the leftover argument is the program
##
file=$1

##
## parameter handling
#
if [ -z "${package}" ] ; then
    package=${defaultp}
fi

##
## log file handling
##
if [ -z "${fulllog}" ] ; then
    fulllog=${executable}.log
    rm -f ${fulllog}
fi
logdir=${fulllog} && logdir=${fulllog%%/*}
if [ -z "${logdir}" ] ; then logdir="." ; fi
if [ ! -d "${logdir}" ] ; then
    echo "INTERNAL ERROR null logdir in log: ${fulllog}" && exit 1
fi
testlog="${logdir}/${source}.log"
rm -rf ${testlog} && touch ${testlog}

if [ ! -z "${testcaption}" ] ; then
    echo "---- Test: ${testcaption}" | tee -a ${testlog}
fi

pathmacro=TACC_$( echo ${package} | tr a-z A-Z )_$( echo ${dir} | tr a-z A-Z )
##echo "path macro: $pathmacro"
eval filename=\${${pathmacro}}/${file}

##echo "test file: <<${filename}>>"
if [ -f "${filename}" ] ; then
    failure 0 "found file <<$file>> in section <<$dir>>" | tee -a ${testlog}
else
    failure 1 "file <<$file>> in section <<$dir>>" | tee -a ${testlog}
fi

cat ${testlog} >> ${fulllog}
