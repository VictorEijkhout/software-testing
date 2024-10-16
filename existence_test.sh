#!/bin/bash

##
## Existence test
##

buildsystem=cmake
source ../functions.sh
source ../driver_options.sh
source ../failure.sh

##
## the leftover argument is the program
##
source=$1

echo "Testing existence of file <<$source>> in section <<${dir}>>" >>${testlog}
print_test_caption "${testcaption}" "${testlog}"

pathmacro=TACC_$( echo ${package} | tr a-z A-Z )_$( echo ${dir} | tr a-z A-Z )
echo "path macro=${pathmacro}" >>${testlog}
eval export fullpath=\${${pathmacro}}
echo "full path=${fullpath}"   >>${testlog}
export filename=${fullpath}/${source}

echo "test file: <<${filename}>> from <<${pathmacro}=${fullpath}>> / ${source}" \
    >>${testlog}
if [ -f "${filename}" ] ; then
    failure 0 "file <<$source>> in section <<$dir>>" | tee -a ${testlog}
else
    failure 1 "file <<$source>> in section <<$dir>>" | tee -a ${testlog}
    ( echo "dir contents of <<${fullpath}>>:" && ls -d ${fullpath}/* ) >>${fulllog}
fi

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>${fulllog}
cat ${testlog} >> ${fulllog}
