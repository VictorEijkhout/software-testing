${PROJECTNAME}.o : ${SRCDIR}/${PROJECTNAME}.cu
	nvcc -c -o $@ $^
${PROJECTNAME} : ${PROJECTNAME}.o
	nvcc -o $@ -ccbin gcc $^
