TESTS = 
TEST = 
include ../Make.common
clean ::
	@rm -rf *.pyc pylauncher_* queuestate* jobscript

LAUNCHER = classic
TIME = 0:20:0
info ::
	@echo "make submit"
	@echo "    [ LAUNCHER= (default: ${LAUNCHER}) ]"
	@echo "    [ TIME=h:m:2 (default: ${TIME}) ]"
.PHONY: submit
submit :
	@cat jobscript.${TACC_SYSTEM} \
	    | sed \
	        -e 's/LAUNCHER/'${LAUNCHER}'/' \
	        -e 's/TIME/'${TIME}'/' \
	    > jobscript
	@sbatch jobscript



