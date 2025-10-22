${PROJECTNAME} : ${SRCDIR}/${PROJECTNAME}.cc
	@if [ -z "${TACC_CC}" ] ; then \
	  echo "THIS COMPILER DOES NOT DEFINE TACC_CC" && exit 1 ; fi 
	@echo "nc-config --cflags: $$( nc-config --cflags )"
	@echo "nc-config --libs  : $$( nc-config --libs  )"
	${TACC_CC} -o $@ $^ \
	  $$( nc-config --cflags ) \
	  $$( nc-config --libs  )
