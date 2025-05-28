${PROJECTNAME}.o : ${SRCDIR}/${PROJECTNAME}.c
	${TACC_CC} -c -o $@ $^ \
	  -I${TACC_FFTW2_INC} \
	  -L${TACC_FFTW2_LIB} -lfftw2
