#!/bin/bash

source ../test_setup.sh

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
    --ldd -r \
    --dir lib libblis.so

##
cd c
make clean \
    BLIS_INSTALL_PATH=${TACC_BLIS_DIR}
rm -f *.x *.o *~
make 00obj_basic.x \
    ENABLE_VERBOSE=yes CC=${TACC_CC} \
    BLIS_INSTALL_PATH=${TACC_BLIS_DIR}
