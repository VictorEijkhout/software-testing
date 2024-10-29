#!/bin/bash

buildsystem=petsc
source ../functions.sh

##
## Test a program C/F given externally loaded compiler/mpi
## the output of this script is caught externally by make_test_driver.sh
##

package=unknownpackage
moduleversion="unknownversion"
variant="default"
mpi=

parse_build_options

echo "----" && echo "testing <<${variant}/${program}>>" && echo "----"
rm -rf build && mkdir build && pushd build >/dev/null

set_compilers

incpath=TACC_$( echo ${package} | tr a-z A-Z )_INC
eval incpath=\${${incpath}}
cmdline="${compiler} -o ${base} ../${lang}/${base}.${lang} -I${incpath}"
echo "cmdline=${cmdline}"
retcode=0
eval ${cmdline} || retcode=$?

build_final_report

popd >/dev/null

