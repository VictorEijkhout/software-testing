info ::
	@echo "make test TEST=..."
	@echo "    from tests: ${TESTS}"
TESTS = mumpsi64
TEST = mumpsi64
.PHONY: test
test :
	@fn=${TEST}_${TACC_SYSTEM}.sh \
	 && if [ ! -f $${fn} ] ; then \
	      echo "No such script: $${fn}" && exit 1 ; fi \
	 && eval ./$${fn}

clean ::
	@rm -f a.out ${TESTS} *.o *~

