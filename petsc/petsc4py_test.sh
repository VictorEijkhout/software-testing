#!/bin/bash

##
## Test the presence of  petsc4py & slepc4py
## given externally loaded compiler/mpi
##

if [ $# -lt 1 ] ; then 
    echo "Usage: $0 [ -c compilername ] [ -v moduleversion ] " && exit 1
fi

compiler=${TACC_FAMILY_COMPILER}
version="unknownversion"
while [ $# -gt 1 ] ; do
    if [ $1 = "-c" ] ; then
	shift && compiler=$1 && shift 
    elif [ $1 = "-v" ] ; then
	shift && version=$1 && shift 
    fi
done

python3 -c "import petsc4py,slepc4py"
