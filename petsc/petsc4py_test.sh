#!/bin/bash

##
## Test the presence of  petsc4py & slepc4py
## given externally loaded compiler/mpi
##

function usage() {
    echo "Usage: $0 [ -c compilername ] [ -v moduleversion ] " 
}

compiler=${TACC_FAMILY_COMPILER}
version="unknownversion"
while [ $# -gt 0 ] ; do
    if [ "$1" = "-h" ] ; then
	usage && return 0;
    elif [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift 
    elif [ $1 = "-v" ] ; then
	shift && version=$1 && shift 
    fi
done

python3 -c "import petsc4py,slepc4py"
