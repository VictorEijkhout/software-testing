#!/bin/bash

export cores_per_node=$(
    case ${TACC_SYSTEM} in \
	( vista ) echo 112 ;;
	( frontera )  echo 56 ;;
	( ls6 ) echo 128 ;;
	( stampede ) echo 48 ;;
    esac )
echo "Using ${cores_per_node} cores per node"

make clean 
# classic comma ibrun
for e in node ; do 
    echo "Running example: $e"
    make --no-print-directory script submit \
	NAME=${e} \
	CORESPERNODE=${cores_per_node} \
	EXECUTABLE=example_${e}_launcher
done

