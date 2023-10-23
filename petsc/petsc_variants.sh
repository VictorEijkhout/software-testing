#!/bin/bash

EXTENSIONS=" \
    "" debug i64 i64-debug single single-debug \
    complex complex-debug complexi64 complexi64-debug \
    nohdf5 i64nohdf5 \
    "
for e in "" ${EXTENSIONS} ; do
    variant=3.20
    if [ ! -z "${e}" ] ; then \
	variant=${variant}-$e
    fi
    retcode=0
    module load petsc/${variant} >/dev/null 2>1 || retcode=$?
    if [ $retcode -gt 0 ] ; then 
	echo "    variant not available: $variant"
    else
	echo "    loaded variant: ${variant}"
	./petsc_tests.sh
    fi
done
