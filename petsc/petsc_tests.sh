#!/bin/bash

source ../test_setup.sh
python_option=1
do_c=1 && do_f=1 && do_py=1
if [ ! -z "${docuda}" ] ; then
    echo " .. skipping C / F / Py because of CUDA"
    do_c="" && do_f="" && do_py=""
fi

if [ ! -z "${python_only}" ] ; then
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
    source petsc_k_tests.sh
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
    echo ".... skipping python tests" | tee -a ${logfile}
fi

##
## CUDA tests
##
if [ ! -z "${docuda}" ] ; then
    echo "CUDA language"
    ../petsc_test_driver.sh ${standardflags} -l ${logfile} \
			   --title "cu example 47" \
			   --run_args "-dm_vec_type cuda -da_grid_x 3000000" \
			   ex47cu.cu
fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi | tee -a ${logfile}
