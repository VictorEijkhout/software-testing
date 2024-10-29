#!/bin/bash

buildsystem=cmake
source ../functions.sh

##
## Test a program C/F given externally loaded compiler/mpi
## the output of this script is caught externally by cmake_test_driver.sh
##

package=unknownpackage
moduleversion="unknownversion"
variant="default"
cmake=
mpi=

cmd_args="$*"
parse_build_options $*

echo "----" && echo "testing <<${variant}/${program}>>" && echo "----"
rm -rf build && mkdir build && pushd build >/dev/null

set_compilers
echo "Using cmake: $( cmake --version | head -n 1 ) with CC=${CC}, CXX=${CXX}, FC=${FC}"

retcode=0 && cmake -D CMAKE_VERBOSE_MAKEFILE=ON \
    -D PROJECTNAME=${base} \
    $( if [ ! -z "${cmake}" ] ; then echo ${cmake} | tr ',' ' ' ; fi ) \
    ../${variant} || retcode=$?
if [ ${retcode} -ne 0 ] ; then 
    echo
    echo "    ERROR CMake failed program=${program} and ${package}/${v}; exit ${retcode}"
    echo
    exit ${retcode}
fi

retcode=0 && make || retcode=$?

build_final_report

popd >/dev/null

