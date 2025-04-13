#!/bin/bash

source ../test_setup.sh
python_option=1
if [ ! -z "${docuda}" ] ; then
    echo " .. skipping C / F / Py because of CUDA"
    skipc=1 && skipf=1 && dopy=""
fi


##
## C tests
##
if [ "${skipc}" != "1" ] ; then
    echo "C language"

    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
			    --title "Sanity test" \
			    sanity.c

    # echo "Test if we have amgx preconditioner"
    # retcode=0
    # ../cmake_build_single.sh -m -p ${package} amgx.c >>${logfile} 2>&1 || retcode=$?
    # failure $retcode "amgx compilation"

    if [[ "${PETSC_ARCH}" = *single* ]] ; then
	realsize=4 ; else realsize=8 ; fi
    if [[ "${PETSC_ARCH}" = *complex* ]] ; then
	realsize=$(( realsize * 2 )) ; fi
    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
			    --title "size of scalar" \
	-t ${realsize} \
	scalar.c

    if [[ "${PETSC_ARCH}" = *i64* ]] ; then
	intsize=8 ; else intsize=4 ; fi
    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
			    --title "size of int" \
	-t ${intsize} \
	int.c

    if [[ "${PETSC_ARCH}" = *complex* ]] ; then
	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
				--title "complex type" \
				complex.c
    fi

    # if [ "${TACC_SYSTEM}" != "vista" ] ; then 
    # 	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    # 	    -d phdf5 \
    #                         ${p4pflag} \
    # 			    --title "presence of hdf5" \
    # 			    hdf5.c
    # fi

	# ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
        #                     ${p4pflag} \
	# 		    --title "presence of fftw3" \
	# -t accuracy \
	# fftw3.c

    if [[ "${PETSC_ARCH}" == *i64* ]] ; then 
	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
				--title "presence of mumpsi64" \
				mumpsi64.c
    fi

    fftw3_extra_test="-t accuracy"
    for package in fftw3 mumps parmetis phdf5 ptscotch strumpack superlu superlu_dist ; do
	if [[ "${PETSC_ARCH}" == *i64* ]] ; then
	    if [[ "$package" == chaco ]] ; then continue ; fi
	    if [[ "$package" == parmetis ]] ; then continue ; fi
	    if [[ "$package" == superlu* ]] ; then continue ; fi
	fi
	if [[ "${PETSC_ARCH}" == *single* ]] ; then
	    if [[ "$package" == fftw3 ]] ; then continue ; fi
	    if [[ "$package" == *hdf5 ]] ; then continue ; fi
	    if [[ "$package" == hypre ]] ; then continue ; fi
	    if [[ "$package" == mumps ]] ; then continue ; fi
	fi
	if [[ "${PETSC_ARCH}" == *complex* ]] ; then
	    if [[ "$package" == hypre ]] ; then continue ; fi
	fi
	eval extra_test=\${${package}_extra_test}
	../cmake_test_driver.sh \
	    ${standardflags} -l ${logfile} ${p4pflag} \
	    ${extra_test} \
	    --title "presence of ${package}" \
	    ${package}.c
    done

	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
			    --cmake "-DUSESLEPC=ON" \
			    --title "presence of slepc" \
			    slepceps.c
fi

##
## Fortran tests
##
if [ "${skipf}" != "1" ] ; then
    echo "Fortran language"

	# ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
	    # --title "can we compile fortran"
	    # fortran.F90

    if [[ "${PETSC_ARCH}" != *f08* ]] ; then 
	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                            ${p4pflag} \
				--title "can we compile Fortran1990" \
				fortran1990.F90

	##
	## this uses finclude/petsc.h
	## which bizarrely make the compiler hang
	##
	# ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
        #                     ${p4pflag} \
	# 			--title "F90 vector insertion" \
	# 			vec.F90
    else echo ".... skip f90 test" | tee -a ${logfile}
    fi

    if [[ "${PETSC_ARCH}" = *f08* ]] ; then 
	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
				--title "can we compile Fortran2008" \
				fortran2008.F90
    else echo ".... skip f08 test" | tee -a ${logfile}
    fi
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

##
## Python tests
##
if [ ! -z "${dopy}" ] ; then 
    echo "Python language" | tee -a ${logfile}
    module load python3 && module list 2>/dev/null

    ../python_test_driver.sh -p ${package} -l ${logfile} \
	--title "import 4py modules" \
	import.py

    ../python_test_driver.sh -p ${package} -l ${logfile} \
	--title "Test init from argv" \
	p4p.py 

    ../python_test_driver.sh -p ${package} -l ${logfile} \
	--title "Python allreduce" \
        allreduce.py

else echo ".... skipping python tests" | tee -a ${logfile}
fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi | tee -a ${logfile}

