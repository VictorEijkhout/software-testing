#!/bin/bash

buildsystem=make
source ../functions.sh

##
## Test a program C/F given externally loaded compiler/mpi
## the output of this script is caught externally by make_test_driver.sh
##

package=unknownpackage
moduleversion="unknownversion"
variant="default"
mpi=

cmd_args="$*"
parse_build_options $*

echo "----" && echo "testing <<${variant}/${program}>>" && echo "----"
rm -rf build && mkdir build && pushd build >/dev/null

set_compilers
echo "Using auto tools"

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

incpath=TACC_$( echo ${package} | tr a-z A-Z )_INC
eval incpath=\${${incpath}}
cmdline="${compiler} -o ${base} ../${lang}/${base}.${lang} -I${incpath}"
echo "cmdline=${cmdline}"
retcode=0
eval ${cmdline} || retcode=$?

build_final_report

popd >/dev/null

