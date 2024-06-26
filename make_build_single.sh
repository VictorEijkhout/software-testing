#!/bin/bash

##
## Test a program C/F given externally loaded compiler/mpi
## the output of this script is caught externally by make_test_driver.sh
##

function usage() {
    echo "Usage: $0 [ -m moduleversion ] [ -p package ]  [ -v variant ] [ -x (set -x) ]"
    echo "    program.c/cxx/F90" 
}

package=unknownpackage
moduleversion="unknownversion"
variant="default"
if [ $# -eq 1 -a "$1" = "-h" ] ; then
    usage && exit 0 
fi
while [ $# -gt 1 ] ; do
    if [ $1 = "-p" ] ; then 
	shift && package=$1 && shift
    elif [ $1 = "-m" ] ; then
	shift && moduleversion=$1 && shift 
    elif [ $1 = "-v" ] ; then
	shift && variant=$1 && shift 
    elif [ $1 = "-x" ] ; then
	shift && set -x
    fi
done

if [ $# -eq 0 ] ; then
    usage && exit 1
fi

program=$1
base=${program%.*}
lang=${program#*.}
if [ "${variant}" = "default" ] ; then
    variant=${lang}
fi

if [ ! -d "${variant}" ] ; then
    echo "ERROR no language directory <<${variant}>>" && return 1
fi

echo "----" && echo "testing <<${variant}/${program}>>" && echo "----"
rm -rf build && mkdir build && pushd build >/dev/null

compiler=
case "${lang}" in 
    ( c ) compiler=${TACC_CC} ;;
    ( cxx ) compiler=${TACC_CXX} ;;
    ( F90 ) compiler=${TACC_FC} ;;
esac
if [ -z "${compiler}" ] ; then
    echo "ERROR could not set compiler for extension <<${lang}>>"
    exit 1
fi
incpath=TACC_$( echo ${package} | tr a-z A-Z )_INC
eval incpath=\${${incpath}}
cmdline="${compiler} -o ${base} ../${lang}/${base}.${lang} -I${incpath}"
echo "cmdline=${cmdline}"
retcode=0
eval ${cmdline} || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "    ERROR compilation failed program=${program} and ${package}/${v}"
    echo
    exit ${retcode}
fi
echo "    SUCCESS"
popd >/dev/null

