#!/bin/sh

# This incantation from:
# https://stackoverflow.com/questions/3915040/how-to-obtain-the-absolute-path-of-a-file-via-shell-bash-zsh-sh

get_abs_filename() {
  # $1 : relative filename
  if [ -d "$(dirname "$1")" ]; then
    echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
  fi
}

if [ -z $EXEC_PREFIX ]
then
  export EXEC_PREFIX="$1"
fi
SIESTA_REL_PATH="$2"

if [ -z $ABS_EXEC_DIR ]
then
  export ABS_EXEC_DIR=$( get_abs_filename ${SIESTA_REL_PATH} )
fi
if [ -z $SIESTA ]
then
  export SIESTA="$EXEC_PREFIX ${ABS_EXEC_DIR}/siesta"
fi
if [ -z $SIESTA_PS_PATH ]
then
  if [ -z $PS_PATH_HINT ]
  then
    export SIESTA_PS_PATH=$(get_abs_filename "../../Pseudos")
  else
    export SIESTA_PS_PATH=$(get_abs_filename ${PS_PATH_HINT})
  fi
fi

# Failsafe for weird OMP behaviour.
if [ -z $OMP_NUM_THREADS ]
then
  export OMP_NUM_THREADS=1
fi
