#!/bin/bash

##
## run tests, given a loaded environment
##

package=$(pwd) && package=${package##*/}

source ../options.sh
source ../failure.sh

../existence_test.sh -p ${package} -l ${logfile} \
		     --title "core header" \
		     -d lib libproj.so

testlog="${logdir}/${source}.log"
rm -f ${testlog} && touch ${testlog}
echo "Running bin/proj" | tee -a ${testlog}
${TACC_PROJ_DIR}/bin/proj >binrun.log 2>&1
success=$( cat binrun.log | grep usage | wc -l )
if [ $success -eq 1 ] ; then 
    failure 0 "able to run proj program" | tee -a ${testlog}
else
    failure 1 "failure to run proj program" | tee -a ${testlog}
fi

cat ${testlog} >> ${logfile}

