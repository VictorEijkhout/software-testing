info ::
	@echo "make test TEST=..."
	@echo "    from tests: ${TESTS}"
TESTS = fmod
TEST = fmod
.PHONY: test
test :
	@fn=${TEST}_${TACC_SYSTEM}.sh \
	 && if [ ! -f $${fn} ] ; then \
	      echo "No such script: $${fn}" && exit 1 ; fi \
	 && eval ./$${fn}

clean ::
	@rm -f ${TESTS} *.o *~

