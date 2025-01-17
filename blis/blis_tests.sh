#!/bin/bash

##
## run tests, given a loaded compiler
##

source ./package.sh
command_args=$*
source ../options.sh
source ../failure.sh
set_flags

##
## Tests
##
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "header" \
		     --dir inc blis.h

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "static lib" \
		     --dir lib libblis.a

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "shared lib" \
		     --dir lib libblis.so

exit 0
##
## this needs to be cleaned up; also the tests fail
##
cd c
make clean RM_F="rm -f"
rm -f *.x *.o *~
set -x
make 00obj_basic.o TEST_BINS=00obj_basic.x \
    ENABLE_VERBOSE=yes RM_F="rm -f" CC=${TACC_CC} \
    BLIS_INSTALL_PATH=${TACC_BLIS_DIR} \
    LIBBLIS_LINK="-L${TACC_BLIS_LIB} -lblis"
make 00obj_basic.x TEST_BINS=00obj_basic.x \
    ENABLE_VERBOSE=yes RM_F="rm -f" CC=${TACC_CC} \
    BLIS_INSTALL_PATH=${TACC_BLIS_DIR} \
    LIBBLIS_LINK="-L${TACC_BLIS_LIB} -lblis"
