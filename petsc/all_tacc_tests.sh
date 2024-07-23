#!/bin/bash

base=3.21
for variant in \
    "" debug complex i64 f08 single \
    ; do
    if [ -z "${variant}" ] ; then
        version=${base}
    else
        version=${base}-${variant}
    fi
    echo "==== Testing version ${version}"
    ./tacc_tests.sh -4 -v ${version} \
        | awk '\
        /Configuration/ { configuration=$3 } \
	/^---- / { $1="" ; test=$0 } \
	/ERROR/ { printf("Error configuration <<%s>> test <<%s>>\n",configuration,test) } \
	'
done
