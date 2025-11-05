#!/bin/bash

function usage () {
    echo "Usage: $0 [ -h ] [ -t : trace ]"
    echo "    [ -s 1.23 :  symbols for version ] [ -l : versions ]"
    echo "    [ symbol ]"
}

function trace () {
    if [ ! -z "$tracing" ] ; then
	echo $1
    fi
}

list=
symbol=
symbolversion=
tracing=
while [ $# -gt 0 ] ; do
    if [ $1 = "-h" ] ; then
	usage && exit 0
    elif [ $1 = "-s" ] ; then
	shift && symbolversion=$1 && shift
	trace "Searching for symbols for version <<$symbolversion>>"
    elif [ $1 = "-l" ] ; then
	list=1 && shift
	trace "Listing all versions"
    elif [ $1 = "-t" ] ; then
	tracing=1 && shift
	trace "Tracing on"
    elif [ $# -eq 1 ] ; then
	symbol=$1
	trace "Finding versions of symbol <<$symbol>>"
	break
    else
	echo "Unknown option or argument: <<$1>>" && exit 1
    fi
done

for libc in /usr/lib/libc.so /usr/lib64/libc.so ; do
    ls ${libc}* >/dev/null 2>&1
    if [ $? -eq 0 ] ; then
	break
    fi
done
libc=$( ls ${libc}.[0-9]* )
trace "Found: ${libc}"


#
# Find exact symbol
#
if [ ! -z "${symbol}" ] ; then
    trace "Find exact symbol <<$symbol>>"
    strings ${libc} | grep -i "${symbol}.*GLIBC"
fi

#
# Find GLIBC versions
#
if [ ! -z $list ] ; then
    trace "List GLIBC versions"
    for sym in $glibc ; do
	echo $sym | cut -d '@' -f 2
    done | grep '^GLIBC' | sort -u | sed -e 's/GLIBC_//'
fi

#
# Find versions of symbol
#
if [ ! -z $symbolversion ] ; then
    trace "Find versions of symbol <<$symbolversion>>"
    strings ${libc} \
	| grep $symbolversion | grep '^GLIBC' 
fi
