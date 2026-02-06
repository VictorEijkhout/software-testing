#!/bin/bash

source ../test_setup.sh
python_option=1
do_c=1 && do_f=1 && do_py=
if [ ! -z "${docuda}" ] ; then
    echo " .. skipping C / F / Py because of CUDA"
    do_c="" && do_f="" && do_py=""
fi

if [ ! -z "${nofortran}" ] ; then
    do_f=""
fi

if [ ! -z "${pythononly}" ] ; then
    do_c=""
    do_f=""
    do_py="1"
fi

##
## without this we're sunk
##
../existence_test.sh ${standardflags} -l ${logfile} \
		     --title "petsc.pc" \
		     --dir lib pkgconfig/PETSc.pc

../existence_test.sh ${standardflags} -l ${logfile} \
		     --title "libpetsc.so" \
		     --ldd \
		     --dir lib libpetsc.so


##
## C tests
##
if [ ! -z "${do_c}" ] ; then
    echo "C language" | tee -a ${logfile}
    source petsc_c_tests.sh
    if [[ ${version} = *kokkos* ]] ; then
	source petsc_k_tests.sh
    fi
else
    echo "skip C tests" | tee -a ${logfile}
fi

##
## Fortran tests
##
if [ ! -z "${do_f}" ] ; then
    echo "Fortran language" | tee -a ${logfile}
    source petsc_f_tests.sh
else
    echo "skip Fortran tests" | tee -a ${logfile}
fi

##
## Python tests
##
if [ ! -z "${do_py}" ] ; then 
    echo "Python language" | tee -a ${logfile}
    source petsc_py_tests.sh
else
    echo "skipping python tests" | tee -a ${logfile}
fi

##
## CUDA tests
##
havecuda=$( grep -i have_cuda ${TACC_PETSC_DIR}/include/petscconf.h | head -n 1 | cut -d ' ' -f 3 )
../info_test.sh ${standardflags} -l ${logfile} \
		--title "Presence of cuda" \
		--info "Configured with CUDA" \
		"${havecuda}"

# if [ "${havecuda}" = "1" ] ; then
#     failure 0 "Configured with CUDA"
# else
#     failure 0 "Configured without CUDA"
# fi

if [ ! -z "${docuda}" ] ; then
    echo "CUDA language"
    source petsc_cuda_tests.sh
fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi | tee -a ${logfile}
