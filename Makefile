info ::
	@echo "make clean"
clean ::
	@rm -f a.out ${TESTS} *.o *~ *.out
	@rm -rf build all_logs
clean ::
	@for d in * ; do \
	  if [ -d $$d ] ; then \
	    echo "clean: $$d" \
	     && ( cd $$d && \
	        if [ -f Configuration ] ; then \
	            mpm.py clean \
	        ; else \
	            make --no-print-directory clean \
	        ; fi \
	        ) \
	  ; fi \
	; done
