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

##
## syntax error
##
# ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
    #                         ${p4pflag} \
    # 			    --cmake "-DUSESLEPC=ON" \
    # 			    --title "presence of slepc" \
    # 			    slepceps.F90

if [[ "${PETSC_ARCH}" = *f08* ]] ; then 
    ../cmake_test_driver.sh ${standardflags} -l ${logfile} \
			    --title "can we compile Fortran2008" \
			    fortran2008.F90
else echo ".... skip f08 test" | tee -a ${logfile}
fi
