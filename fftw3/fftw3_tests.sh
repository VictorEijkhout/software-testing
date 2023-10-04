echo "==== Test if we can compile"
retcode=0
../cmake_test.sh -p ${package} has.c >${compilelog} 2>&1 || retcode=$?
failure $retcode "basic compilation"

echo "==== Test if we can compile single"
retcode=0
../cmake_test.sh -p ${package} -v cf has.c >>${compilelog} 2>&1 || retcode=$?
failure $retcode "single precision compilation"
