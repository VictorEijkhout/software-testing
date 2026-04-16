#!/bin/bash

modulereset ()
{
    module purge;
    module reset;
    if [ $( echo $MODULEPATH | grep $( whoami ) | wc -l ) -gt 0 ]; then
        echo "ERROR still private modules left:";
        echo ${MODULEPATH} | tr ':' '\n';
        exit 1;
    fi
}

host=$(hostname)
host=${host%%.tacc.utexas.edu}
host=${host##*.}
for compiler in $( cat ../compilers_${host}.sh ) ; do
    echo -e "================\nTesting: $compiler\n================"
    modulereset 2>/dev/null
    path=${compiler%%:*}
    if [ ! -z "${path}" ] ; then module use $path ; fi
    compiler=${compiler##*:}
    module -t load $compiler
    if [ $? -gt 0 ] ; then
	echo "could not load compiler"
    else
	mpm.py regression
    fi
done
