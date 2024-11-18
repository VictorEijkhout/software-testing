#!/bin/bash

##
## Dynamic library test
##

buildsystem=cmake
source ../functions.sh
source ../driver_options.sh
source ../failure.sh

##
## the leftover argument is the program
##
testlib=$1

if [ ! -f "${testlog}" ] ; then 
    echo "WARNING test log <<${testlog}>> does not exist in existencetest"
fi
echo "Testing shared libraries from <<$testlib>>" >>${testlog}

eval libdir=\${TACC_$( echo ${package} | tr a-z A-Z )_LIB}
libfile=${libdir}/${testlib}
if [ ! -f "${libfile}" ] ; then
    failure 1 "not found lib file <<${libfile}>>"
else
    unresolved=$( ldd "${libfile}" | grep "not found" | wc -l )
    if [ ${unresolved} -eq 0 ] ; then
	failure 0 "lib <<$testlib>> no unresolved references" | tee -a ${testlog}
    else
	failure 1 "lib <<$testlib>> unresolved libraries" | tee -a ${testlog}
	for l in $( ldd ${libdir}/${testlib} | grep "not found" | awk '{print $1}' ) ; do
	    echo "${l}"
	done >>${testlog}
    fi
fi

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>${fulllog}
cat ${testlog} >> ${fulllog}
