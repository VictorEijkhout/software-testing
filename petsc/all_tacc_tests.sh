#!/bin/bash

base_version=3.21
for variant in \
    "" debug \
    ; do
    if [ -z "${variant}" ] ; then
        version=${base_varion}
    else
        version=${base_varion}-${variant}
    fi
    echo "==== Testing version ${version}"
    ./tacc_tests.sh -4 -v ${version} \
        | awk '\
        /Configuration/ { configuration=$3 } \
	/^----/ { $1="" ; test=$0 } \
	/ERROR/ { printf("Error configuration <<%s>> test <<%s>>\n",configuration,test) } \
	'
done
