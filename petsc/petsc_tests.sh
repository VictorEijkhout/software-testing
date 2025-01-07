#!/bin/bash

##
## run tests, given a loaded compiler & petsc version
##

source ./package.sh

command_args=$*
python_option=1
source ../options.sh

set_flags
if [ "${skipcuda}" != "1" ] ; then
    echo " .. skipping C / F / Py because of CUDA"
    skipc=1 && skipf=1 && skippy=1
fi

source ../failure.sh

##
## C tests
##
if [ "${skipc}" != "1" ] ; then
    echo "C language"

    ../cmake_test_driver.sh ${standardflags} \
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
    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "size of scalar" \
	-t ${realsize} \
	scalar.c

    if [[ "${PETSC_ARCH}" = *i64* ]] ; then
	intsize=8 ; else intsize=4 ; fi
    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "size of int" \
	-t ${intsize} \
	int.c

    if [[ "${PETSC_ARCH}" = *complex* ]] ; then
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "complex type" \
				complex.c
    fi

    if [ "${TACC_SYSTEM}" != "vista" ] ; then 
    ../cmake_test_driver.sh -d phdf5 ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of hdf5" \
			    hdf5.c
    fi

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of fftw3" \
	-t accuracy \
	fftw3.c

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of mumps" \
			    mumps.c

    if [[ "${PETSC_ARCH}" == *i64* ]] ; then 
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "presence of mumpsi64" \
				mumpsi64.c
    fi

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of parmetis" \
			    parmetis.c

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
			    --title "presence of ptscotch" \
			    ptscotch.c

    ../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
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
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "can we compile Fortran1990" \
				fortran1990.F90

	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
                            ${p4pflag} \
				--title "F90 vector insertion" \
				vec.F90
    else echo ".... skip f90 test" | tee -a ${logfile}
    fi

    if [[ "${PETSC_ARCH}" = *f08* ]] ; then 
	../cmake_test_driver.sh ${mpiflag} ${runflag} ${xflag} -p ${package} -l ${logfile} \
				--title "can we compile Fortran2008" \
				fortran2008.F90
    else echo ".... skip f08 test" | tee -a ${logfile}
    fi
fi

##
## CUDA tests
##
if [ "${skipcuda}" != "1" ] ; then
    echo "CUDA language"
    ../cmake_test_driver.sh ${standardflags} \
			    --title "cu example 47" \
			    ex47cu.cu
    ../petsc_test_driver.sh ${standardflags} \
			   --title "cu example 47" \
			   ex47cu.cu
    # PETSC_CUCOMPILE_SINGLE  = ${CUDAC} -o $*.o -c $(MPICXX_INCLUDES) ${CUDAC_FLAGS} ${CUDAFLAGS} ${CUDAC_HOSTFLAGS} ${CUDACPPFLAGS} --compiler-options="${CXXCPPFLAGS}"
    # generated compile line:
    # nvcc -o ex47cu.o -c -I/opt/apps/nvidia24/openmpi/5.0.5_nvc249/include  -ccbin mpicxx -std=c++20 -Xcompiler -fPIC -Xcompiler -fvisibility=hidden -Xcompiler -fvisibility=hidden -g -lineinfo -arch=sm_70      --compiler-options="-I/work/00434/eijkhout/petsc/installation-petsc-3.22.0-vista-nvidia24.9-openmpi5.0.5_nvc249-3.22.0-cuda/3.22.0-cuda/include -I/home1/apps/nvidia/Linux_aarch64/24.9/cuda/include -I/home1/apps/nvidia/Linux_aarch64/24.9/math_libs/include   " ex47cu.cu
    # mpicc -O2 -fPIC   -Wl,-export-dynamic ex47cu.o  -Wl,-rpath,/work/00434/eijkhout/petsc/installation-petsc-3.22.0-vista-nvidia24.9-openmpi5.0.5_nvc249-3.22.0-cuda/3.22.0-cuda/lib -L/work/00434/eijkhout/petsc/installation-petsc-3.22.0-vista-nvidia24.9-openmpi5.0.5_nvc249-3.22.0-cuda/3.22.0-cuda/lib -Wl,-rpath,/home1/apps/nvidia/Linux_aarch64/24.7/math_libs/nvpl/lib -L/home1/apps/nvidia/Linux_aarch64/24.7/math_libs/nvpl/lib -Wl,-rpath,/work/00434/eijkhout/petsc/installation-petsc-3.22.0-vista-nvidia24.9-openmpi5.0.5_nvc249-3.22.0-cuda/3.22.0-cuda/lib -L/work/00434/eijkhout/petsc/installation-petsc-3.22.0-vista-nvidia24.9-openmpi5.0.5_nvc249-3.22.0-cuda/3.22.0-cuda/lib -Wl,-rpath,/home1/apps/nvidia/Linux_aarch64/24.9/math_libs/lib64 -L/home1/apps/nvidia/Linux_aarch64/24.9/math_libs/lib64 -Wl,-rpath,/home1/apps/nvidia/Linux_aarch64/24.9/cuda/lib64 -L/home1/apps/nvidia/Linux_aarch64/24.9/cuda/lib64 -L/home1/apps/nvidia/Linux_aarch64/24.9/cuda/lib64/stubs -lpetsc -lnvpl_lapack_lp64_seq -lnvpl_lapack_core -lnvpl_blas_lp64_seq -lnvpl_blas_core -lchaco -lcufft -lcublas -lcusparse -lcusolver -lcurand -lcudart -lnvToolsExt -lcuda -lX11 -lstdc++ -o ex47cu

    
fi

##
## Python tests
##
if [ "${skippy}" != "1" ] ; then 
    echo "Python language" | tee -a ${logfile}

    set -o pipefail

    echo "Test if we have python interfaces" | tee -a ${logfile}
    retcode=0 && ( cd p && ibrun -n 2 python3 -c "import petsc4py,slepc4py; print(1)" ) \
	| grep -v TACC: || retcode=$?
    failure $retcode "python commandline import"

    echo "Test init from argv" | tee -a ${logfile}
    retcode=0 && ( cd p && ibrun -n 2 python3 p4p.py 2>../err_petsc4py.log ) \
    	| grep -v TACC: || retcode=$?
    failure $retcode "python petsc init"

    echo "Python allreduce" | tee -a ${logfile}
    retcode=0 && ( cd p && ibrun -n 2 python3 allreduce.py ) \
	| grep -v TACC: || retcode=$?
    failure $retcode "python allreduce"
else echo ".... skipping python tests" | tee -a ${logfile}
fi

if [ ! -z "${locallog}" ] ; then 
    echo && echo "See: ${logfile}" && echo
fi | tee -a ${logfile}

