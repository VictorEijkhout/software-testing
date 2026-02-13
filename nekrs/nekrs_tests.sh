#!/bin/bash

source ../test_setup.sh

##
## Tests
##

rm -rf channel/.cache
export NEKRS_HOME=${TACC_NEKRS_DIR}
../existence_test.sh -p ${package} -l ${logfile} \
    --title "channel example" \
    --ldd \
    --run_in_dir channel --run_args "--setup channel/channel.par" \
    --dir bin nekrs

 
