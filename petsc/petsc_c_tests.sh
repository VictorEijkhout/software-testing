../cmake_test_driver.sh ${standardflags} -l ${logfile} \
                        ${p4pflag} \
			--title "Sanity test" \
			sanity.c

if [[ "${PETSC_ARCH}" = *debug* ]] ; then
    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			    ${p4pflag} \
			    --title "Debug enabled" \
			    debug1.c
else
    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			    ${p4pflag} \
			    --title "Debug disabled" \
			    debug0.c
fi

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

##
## Test external packages
##
if [ -z "${small}" ] ; then
    echo "test external packages"
    if [[ "${PETSC_ARCH}" == *i64* ]] ; then 
	../cmake_test_driver.sh ${standardflags} -l ${logfile} \
				${p4pflag} \
				--title "presence of mumpsi64" \
				mumpsi64.c
    fi

    fftw3_extra_test="-t accuracy"
    for package in fftw3 mumps parmetis hdf5 ptscotch strumpack superlu superlu_dist ; do
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
else
    echo "skip external packages" | tee -a ${logfile}
fi

../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			${p4pflag} \
			--cmake "-DUSESLEPC=ON" \
			--title "presence of slepc" \
			slepceps.c
