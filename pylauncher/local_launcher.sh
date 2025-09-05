##
## this needs to be sourced
##

module unload pylauncher 2>/dev/null
export TACC_PYLAUNCHER_DIR=${HOME}/Projects/pylauncher-git
export PYTHONPATH=${PYTHONPATH}:${TACC_PYLAUNCHER_DIR}/src
