#!/bin/bash

package=petsc
module reset >/dev/null 2>&1
echo "==== TACC modules"
for compiler in intel/19 ; do \
    module load $compiler
    ## case $compiler in ( intel* ) cc=icc ;; ( gcc* ) cc=gcc ;; esac
    cc=mpicc
    for v in 3.19-i64 3.19-complexi64 3.18-i64 ; do 
	module load ${package}/$v >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
	    includes=$( cd $PETSC_DIR && make getincludedirs )
	    libs=$( cd $PETSC_DIR && make getlinklibs )
	    echo "compile with ${package} $v"
	    cmdline="$cc -o mumpsi64 mumpsi64.c ${includes} ${libs} "
	    echo " .. $cmdline"
	    retcode=0 && eval $cmdline || retcode=$?
	    if [ ${retcode} -ne 0 ] ; then 
		echo && echo "ERROR compilation failed with compiler=${compiler} and ${package}/${v}" && echo
	    fi
	else
	    echo "could not load ${package}/$v"
	fi
    done
done
