#!/bin/bash

package=petsc
matchversion=3.21

##
## cycle over all available versions
## maybe limited by compiler
##

alllog=all_tacc_tests.log
versions=$( module -t avail ${package} 2>&1 | sed -e '1d' )
for version in ${versions} ; do
    version=${version##${package}/}
    if [[ ${version} = *${matchversion}* ]] ; then 
	echo "Testing version <<$version>>"
	./tacc_tests.sh -v $version $*
    else
	echo "Version skipped: <<$version>>"
    fi 
done 2>&1 | tee ${alllog}
echo && echo "See: ${alllog}" && echo 
