#!/bin/bash

source ../test_setup.sh

##
## Tests
##

## ../cmake_test_driver.sh ${standardflags} -l ${logfile} 
../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     --dir lib libproj.so

testlog="${logdir}/${source}.log"
rm -f ${testlog} && touch ${testlog}
print_test_caption "Running bin/proj" "${testlog}"
${TACC_PROJ_DIR}/bin/proj >binrun.log 2>&1
success=$( cat binrun.log | grep usage | wc -l )
if [ $success -eq 1 ] ; then 
    failure 0 "able to run proj program" | tee -a ${testlog}
else
    failure 1 "failure to run proj program" | tee -a ${testlog}
fi

cat ${testlog} >> ${logfile}

