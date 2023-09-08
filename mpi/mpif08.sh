#!/bin/bash

module reset >/dev/null 2>&1
echo "==== TACC modules"
for compiler in gcc/9 intel/19 gcc13 intel/23 ; do 
    module load $compiler >/dev/null 2>&1
    echo "Trying compiler $compiler"
    if [ $? -eq 0 ] ; then 
	retcode=0 && mpif90 -c mpif08.F90 || retcode=$?
	if [ $retcode -eq 0 ] ; then 
	    echo " .. success"
	else
	    echo && echo "ERROR could not compile with $compiler" && echo
	fi 
    else
	echo " .. could not load compiler $compiler"
    fi
done

