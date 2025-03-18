#!/bin/bash

examples="classic comma filecore ibrun node"
if [ "$1" = "-h" ] ; then
    echo "Usage: $0 [ -h ] [ -e ex1,ex2,ex3,... ]"
    echo " where examples: ${examples}"
    exit 0
fi

while [ $# -gt 0 ] ; do
    if [ "$1" = "-e" ] ; then
	shift && examples=$1 && shift
    # elif [ "$1" = "-g" ] ; then 
    # 	gpu=1 && shift
    else
	echo "Unknown option: $1" && exit 1
    fi
done

QUEUE_frontera=normal
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
for e in \
        $( echo ${examples} | tr ',' ' ' ) \
    ; do 
    echo "Running example: $e"
    make --no-print-directory script submit \
	NAME=${e} \
	QUEUE=$( eval echo \${QUEUE_${TACC_SYSTEM}} ) \
	CORESPERNODE=${cores_per_node} \
	EXECUTABLE=${e}
done

case ${TACC_SYSTEM} in \
    ( vista )
        make --no-print-directory script submit \
	     NAME=gpu EXECUTABLE=gpu
	;;
    ( frontera ) 
        make --no-print-directory script submit \
	     NAME=gpu EXECUTABLE=gpu
	;;
    ( ls6 ) 
        make --no-print-directory script submit \
	     NAME=gpu EXECUTABLE=gpu
	;;
    ( * ) echo "No GPUs on system ${TACC_SYSTEM} to test" ;;
esac

##
## Submit launcher test
## interactively, probably after everything else is done?
##
python3 example_submit_launcher.py 2>&1 | tee -a pylaunchertestsubmit.o000
