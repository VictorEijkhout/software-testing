#!/bin/bash

##
## Existence test
##
## Usage:
## existence_test.sh -p PACKAGE -l LOGFILE
##     --info message
##     value

buildsystem=cmake
source ../functions.sh
source ../driver_options.sh
source ../failure.sh

##
## the leftover argument is the value
##
value=$1

if [ ! -f "${testlog}" ] ; then 
    echo "WARNING test log <<${testlog}>> does not exist in info test"
fi
echo "Testing <<${info}>> with value <<${value}>>" >>"${testlog}"


failure 0 "${info}: <<${value}>>" | tee -a "${testlog}"

echo " .. include testlog <<${testlog}>> into full log: <<${fulllog}>>" >>"${fulllog}"
cat "${testlog}" >> "${fulllog}"
