${PROJECTNAME} : ${SRCDIR}/${PROJECTNAME}.F90
	@if [ -z "${TACC_FC}" ] ; then \
	  echo "THIS COMPILER DOES NOT DEFINE TACC_FC" && exit 1 ; fi 
	@echo "nf-config --fflags: $$( nf-config --fflags )"
	@echo "nf-config --flibs : $$( nf-config --flibs  )"
	${TACC_FC} -o $@ $^ \
	  $$( nf-config --fflags ) \
	  $$( nf-config --flibs  )
