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
echo "Using cmake: $( cmake --version )"

echo
echo " .. using compilers for mpi=${mpi}:"
echo " .. CC=${CC}"
echo "      where ${CC}=$( which ${CC} )"
echo "      and CFLAGS=${CFLAGS}"
echo " .. CXX=${CXX}"
echo "      where ${CXX}=$( which ${CXX} )"
echo "      and CXXFLAGS=${CXXFLAGS}"
echo " .. FC=${FC}"
echo "      where ${FC}=$( which ${FC} )"
echo "      and FFLAGS=${FFLAGS}"

if [ ! -z "${mpi}" ] ; then
    echo 
    echo "  where:"
    testcompiler=$( mpicc -show )
    echo "    mpicc=$( which mpicc )"
    echo "    show: ${testcompiler}"
    basecompiler=$( echo ${testcompiler} | cut -f 1 -d " " )
    echo "    where ${basecompiler}=$( which ${basecompiler} )"

    testcompiler=$( mpicxx -show )
    echo "    mpicxx=$( which mpicxx )"
    echo "    show:  ${testcompiler}"
    basecompiler=$( echo ${testcompiler} | cut -f 1 -d " " )
    echo "    where ${basecompiler}=$( which ${basecompiler} )"
    testcompiler=$( mpif90 -show )
    echo "    mpif90=$( which mpif90 )"
    echo "    show:  ${testcompiler}"
    basecompiler=$( echo ${testcompiler} | cut -f 1 -d " " )
    echo "    where ${basecompiler}=$( which ${basecompiler} )"
fi

echo
echo " .. with PKG_CONFIG_PATH=${PKG_CONFIG_PATH}"
echo " .. with CMAKE_PREFIX_PATH=${CMAKE_PREFIX_PATH}"
echo " .. with LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"
echo 

cmdline="cmake -D CMAKE_VERBOSE_MAKEFILE=ON \
    -D PROJECTNAME=${base} \
    $( if [ ! -z ${cmake} ] ; then echo ${cmake} | tr ',' ' ' ; fi ) \
    ../${variant}"
echo "cmake cmdline: ${cmdline}"
echo " .. with cmake=$( which cmake )"
retcode=0 && eval $cmdline || retcode=$?
if [ ${retcode} -eq 0 ] ; then
    echo && echo "    Cmake completed" && echo
else
    echo
    echo "    ERROR CMake failed program=${program} and ${package}/${v}"
    echo
    exit ${retcode}
fi

echo && echo "Compilation start" && echo 
retcode=0 && make || retcode=$?
echo && echo " .. compilation finished" && echo 

build_final_report

popd >/dev/null

