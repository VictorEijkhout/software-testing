#!/bin/bash

buildsystem=python
source ../functions.sh

##
## Test a python program given externally loaded compiler/mpi
## the output of this script is caught externally by python_test_driver.sh
##

package=unknownpackage
moduleversion="unknownversion"
variant="default"
mpi=

cmd_args="$*"
parse_build_options $*

echo "----" && echo "testing <<${variant}/${program}>>" && echo "----"
rm -rf build && mkdir build && pushd build >/dev/null

# Unused?
# incpath=TACC_$( echo ${package} | tr a-z A-Z )_INC
# eval incpath=\${${incpath}}

##
## What is our python environment?
##
echo "Python3 = $(which python3)"
echo ">> Python path:" && echo $PYTHONPATH | tr ':' '\n' && echo " <<"

srcfile=../${lang}/${base}.${lang}
cp ${srcfile} .
if [ ! -z "${mpi}" ] ; then
    cmdline="ibrun -n 1 python3 ${base}.py"
else
    cmdline="python3 ${base}.py"
fi
echo "cmdline=${cmdline}"
retcode=0
eval ${cmdline} || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "    ERROR Python run failed program=${program} and ${package}/${v}; exit ${retcode}"
    echo
    exit ${retcode}
fi

# leave build directory
popd >/dev/null

