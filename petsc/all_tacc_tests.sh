#!/bin/bash

package=petsc
version=3.20
versions=$( module -t avail ${package} 2>&1 | sed -e '1d' )
for v in ${versions} ; do
    v=${v##${package}/}
    echo "$version <> $v"
    if [[ ${v} = *${version}* ]] ; then 
	./tacc_tests.sh -v $v
    else
	echo " .. skipped"
    fi 
done
