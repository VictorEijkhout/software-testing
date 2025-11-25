#!/bin/bash

source ../test_setup.sh

##
## Tests
##

../existence_test.sh ${standardflags} -l ${logfile} \
		     --title "have main program" \
		     --ldd --run_args -h \
		     --dir bin siesta


../existence_test.sh ${standardflags} -l ${logfile} \
		     --title "run carbon nanoscroll" \
		     --run_args carbon_nanoscroll.fdf --run_in_dir Carbon_Nanoscroll \
		     --dir bin siesta

exit 0

##
## example with lowered precision to make it finish relatively quickly.
##
echo "---- Test: run official example"
test=Carbon_Nanoscroll
rm -rf ${test}
cp -r ${TACC_SIESTA_DIR}/Examples/${test} .
pushd ${test}
# lower tolerance
testfdf=carbon_nanoscroll.fdf
sed -i -e '/Tolerance/s/d-5/d-1/' ${testfdf}
time ( ibrun -np 2 siesta < ${testfdf} 2>/dev/null \
      | grep "End of run:" )
popd

##
## example with lowered precision to make it finish relatively quickly.
##
echo "---- Test: run official example"
test=14.FileIO
#rm -rf ${test}
#cp -r ${TACC_SIESTA_DIR}/Tests/${test} .
pushd Tests/${test}
testfdf=write_ncdf.fdf
# lower tolerance
# sed -i -e '/Tolerance/s/d-5/d-1/' ${testfdf}
time ( ibrun -np 2 siesta < ${testfdf} 2>/dev/null \
      | grep "End of run:" )
popd
