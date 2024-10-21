info ::
	@echo "make clean"
clean ::
	@rm -f a.out ${TESTS} *.o *~ *.out
	@rm -rf build all_logs
clean ::
	@for d in * ; do \
	  if [ -d $$d ] ; then \
	    echo "clean: $$d" \
	     && ( cd $$d && make --no-print-directory clean ) \
	  ; fi \
	; done
