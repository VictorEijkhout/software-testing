#!/bin/bash

##
## Existence test
##
## Usage:
## existence_test.sh -p PACKAGE -l LOGFILE
##    --title "title of this test"
##    -ldd : ldd on executable or library
##    --dir DIR binary-name : tests presence in TACC_<PACKAGE>_<DIR>

buildsystem=cmake
source ../functions.sh
source ../driver_options.sh
source ../failure.sh

##
## the leftover argument is the program
##
source=$1
if [[ ${source} = var=* ]] ; then
    var=$( echo $source | cut -d '=' -f 2 )
    eval source=\${$var}
    if [ -z "${source}" ] ; then
	echo "ERROR variable <<$var>> is undefined"
	exit 1
    fi
fi

if [ ! -f "${testlog}" ] ; then 
    echo "WARNING test log <<${testlog}>> does not exist in existencetest"
fi
echo "Testing existence of file <<$source>> in section <<${dir}>>" >>"${testlog}"

pathmacro=TACC_$( echo ${loadpackage} | tr a-z A-Z )_$( echo ${dir} | tr a-z A-Z )
echo "path macro=${pathmacro}" >>"${testlog}"
eval export fullpath=\${${pathmacro}}
echo "full path=${fullpath}"   >>"${testlog}"
export filename=${fullpath}/${source}

echo "test file: <<${filename}>> from <<${pathmacro}=${fullpath}>> / ${source}" \
    >>"${testlog}"
if [ -f "${filename}" ] ; then
    failure 0 "file <<$source>> in section <<$dir>>" | tee -a "${testlog}"
    if [ ! -z "${ldd}" ] ; then
	( echo "ldd on <<${filename}>>:" && ldd "${filename}" ) >>"${fulllog}"
	unresolved=$( ldd "${filename}" | grep -i "not found" | wc -l )
	failure ${unresolved} "resolving shared libraries" | tee -a "${testlog}"
    fi
    if [ ! -z "${runindir}" -a "${dir}" = "bin" -a ! -z "${run}" ] ; then
	echo "Running ${filename} ${runargs}" >> "${fulllog}"
	export cmdline="${filename} ${runargs}"
	if [ ! -z "${inargs}" ] ; then
	    cmdline="${cmdline} < ${inargs}"
	fi
	if [ "${mpi}" = "1" ] ; then
	    cmdline="ibrun -np 2 ${cmdline}"
	fi
	cmdline="cd ${runindir} && ${cmdline}"
	retcode=$( \
	    echo "running <<${cmdline}>>:" >>"${fulllog}" \
	    && retcode=0 \
	    && ${cmdline} >>"${fulllog}" 2>&1 || retcode=$? \
	    && echo ${retcode} )
	failure ${retcode} "actually running" | tee -a "${testlog}"
    fi
else
    failure 1 "file <<$source>> in section <<$dir>>" | tee -a "${testlog}"
    ( echo "dir contents of <<${fullpath}>>:" && ls -d ${fullpath}/* ) >>"${testlog}"
fi

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>"${fulllog}"
cat "${testlog}" >> "${fulllog}"
