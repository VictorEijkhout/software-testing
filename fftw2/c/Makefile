${PROJECTNAME}.o : ${SRCDIR}/${PROJECTNAME}.c
	@if [ -z "${TACC_CC}" ] ; then \
	  echo "THIS COMPILER DOES NOT DEFINE TACC_CC" && exit 1 ; fi 
	${TACC_CC} -c -o $@ $^ \
	  -I${TACC_FFTW2_INC} \
	  -L${TACC_FFTW2_LIB} -lfftw2
