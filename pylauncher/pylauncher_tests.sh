#!/bin/bash

QUEUE_frontera=small # 2 nodes
QUEUE_ls6=normal
QUEUE_stampede3=skx
QUEUE_vista=gg
export cores_per_node=$(
    case ${TACC_SYSTEM} in \
	( vista ) echo 112 ;;
	( frontera )  echo 56 ;;
	( ls6 ) echo 128 ;;
	( stampede3 ) echo 48 ;;
    esac )
echo "Using ${cores_per_node} cores per node"

make clean 
# 
for e in classic comma ibrun node ; do 
    echo "Running example: $e"
    make --no-print-directory script submit \
	 NAME=${e} \
	 QUEUE=$( eval echo \${QUEUE_${TACC_SYSTEM}} ) \
	 CORESPERNODE=${cores_per_node} \
	 EXECUTABLE=example_${e}_launcher
done

