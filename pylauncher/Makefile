################################################################
####
#### Makefile for the pylauncher examples
#### pylauncher is copyright Victor Eijkhout 2010-2025
####
################################################################

info ::
	@echo "================================================================"
	@echo " This makefile tries to make it easy to run and submit example programs"
	@echo "================================================================"
	@echo 
	@echo "Available make rules:"

EXECUTABLE = classic
SSH =
RUN = python3
NODES = 3
CORESPERNODE = 16
MINUTES = 20
QUEUE = 
info ::
	@echo "================ big test"
	@echo "make launch"
.PHONY: launch
launch :
	@for x in classic core comma node ibrun ; do \
	    make script submit EXECUTABLE=$$x \
	 ; done 
info ::
	@echo "================ script submission"
	@echo "make script submit"
	@echo "    [EXECUTABLE=... (default: ${EXECUTABLE})]"
	@echo "    [NODES=... (default: ${NODES})]"
	@echo "    [CORESPERNODE=... (default: ${CORESPERNODE})]"
	@echo "    [QUEUE=... (default: ${QUEUE})]"
	@echo "  this submits a jobscript (see jobscr.hostname) to the queue"
	@echo "  available programs:"
	@echo "    example_classic_launcher : single core jobs, found in ""commandlines"""
	@echo "    example_core_launcher : mult core jobs (constant count), found in ""commandlines"""
	@echo "    example_variable_core_launcher : variable core jobs, found in ""corecommandlines"""
	@echo "(note: remove the project line or replace by your own!)"
NAME = 
script :
	@export HOSTNAME=`hostname -f | awk -F "." '{print $$2}'` \
	 && echo "generating script for ${EXECUTABLE} on $$HOSTNAME" \
	 \
	 && retcode=0 && which ${RUN} 1>/dev/null || retcode=$$? \
	 && if [ $${retcode} -gt 0 ] ; then \
	      echo "Could not find python executable <<${RUN}>>" && exit 1 \
	    ; fi \
	 && if [ -z "${TACC_PYLAUNCHER_DIR}" ] ; then \
	      echo "No pylauncher module loaded" && exit 1 \
	    ; fi \
	 \
	 && template="jobscript_template" && generated="jobscript_generated" \
	 && if [ -f "example_${EXECUTABLE}_launcher.py" ] ; then \
	      NAME=${EXECUTABLE} \
	       && EXECUTABLE=example_${EXECUTABLE}_launcher \
	    ; else \
	      NAME=${EXECUTABLE##example_} && NAME=$${NAME%%_*} \
	       && EXECUTABLE=${EXECUTABLE} \
	    ; fi \
	 && if [ -z "${QUEUE}" ] ; then \
	      case $$( hostname ) in \
	        ( *frontera* ) \
	            if [ $${EXECUTABLE} = "example_gpu_launcher" ] ; then \
	                        QUEUE=rtx         ; export NGPUS=2 ; \
	            else        QUEUE=development ; fi ;; \
	        ( *ls6* )       \
	            if [ $${EXECUTABLE} = "example_gpu_launcher" ] ; then \
	                        QUEUE=gpu-a100    ; export NGPUS=3 ; \
	            else        QUEUE=normal ; fi ;; \
	        ( *stampede3* ) QUEUE=skx-dev     ;; \
	        ( *vista* )     \
	            if [ $${EXECUTABLE} = "example_gpu_launcher" ] ; then \
	                        QUEUE=gh-dev      ; export NGPUS=2 ; \
	            else        QUEUE=gg     ; fi ;; \
	        ( * )           QUEUE=nosuchqueue ;; \
	    esac \
	    ; else QUEUE=${QUEUE} ; fi \
	 && cat $${template} | sed -e "s/SSH/${SSH}/" -e "s/RUN/${RUN}/" \
	        -e "s/EXECUTABLE/$${EXECUTABLE}/" -e "s/NODES/${NODES}/" \
	        -e "s/NAME/$${NAME}/" -e "s/NGPUS=NGPUS/NGPUS=$${NGPUS}/" \
	        -e "s/CORESPERNODE/${CORESPERNODE}/" -e "s/QUEUE/$${QUEUE}/" \
	        -e "s/MINUTES/${MINUTES}/" \
	        -e "/####/d" \
	        > $${generated}
#PYTHONPATH=../src/pylauncher:${PYTHONPATH}
submit :
	sbatch jobscript_generated

example_shifted_ibrun_dependencies = parallel

include Make.programs

info ::
	@echo 
	@echo "make unittests"
	@echo "  this submits a unittest run (nosetests pylauncher.py) to the queue"
unittests :
	@ln -s ../pylauncher.py pylauncher.py
	@make submit RUN=nosetests EXECUTABLE=pylauncher

##
## input files
##
info ::
	@echo
	@echo "make commandlines [COVERAGE=...] [ NCORES=...] [TIME=...] [COMMAND=...]"
	@echo "    number of jobs = COVERAGE * NCORES"
	@echo "    values: ${COVERAGE} ${NCORES}"
	@echo "make randomcommandlines : use"
	@echo "    COMMAND=\"mkdir -p random/PYL_ID && cd random/PYL_ID && ../../randomaction PYL_ID > random.out\""
NCORES = ${SLURM_NPROCS}
TIME = 20
TMIN = 0
COVERAGE = 4
COMMAND = ./randomsleep
.PHONY : commandlines
commandlines :
	@if [ -z "${NCORES}" ] ; then echo "Please set NCORES variable" && exit 1 ; fi
	@export number_of_jobs=$$[ ${COVERAGE} * ${NCORES} ] \
	&& echo "make $$number_of_jobs commandlines" \
	&& PYTHONPATH=../src/pylauncher:${PYTHONPATH} python3 make_commandlines.py \
	        "${COMMAND}" $$number_of_jobs \
	        `if [ "${TMIN}" = "0" ] ;   then echo 1 ; \
	         elif [ "${TMIN}" = "1" ] ; then echo ${TIME} ; \
	         else                            echo ${TMIN} ; fi` \
	        ${TIME}

.PHONY: randomcommandlines
randomcommandlines :
	@make --no-print-directory commandlines \
	    COVERAGE=${COVERAGE} NCORES=${NCORES} \
	    COMMAND="mkdir -p random/PYL_ID && cd random/PYL_ID && ../../randomaction PYL_ID > random.out"
totalclean ::
	@echo "clean random"
	@rm -rf random

##
## run
##
info ::
	@echo "make localrun EXAMPLE=..."
EXAMPLE = example_classic_launcher.py
.PHONY: localrun
localrun :
	@if [ ! -f "${EXAMPLE}" ] ; then \
	    echo "No such file: ${EXAMPLE}" && exit 1 ; fi 
	PYTHONPATH=../src:${PYTHONPATH} python3 ${EXAMPLE}
clean ::
	@echo "clean tmp dir"
	@/bin/rm -rf pylauncher_tmp*

##
## clean rules
##

info ::
	@echo 
	@echo "make clean totalclean"
.PHONY: clean totalclean
clean ::
	@echo "clean simple files"
	@/bin/rm -f *.pyc *~ *.o *.log \
	      expire* sleepexpire* tmpdir* tasktest* dirtest queuestate* pytmp* \
	      jobscript_generated
	@echo "clean job output"
	@/bin/rm -rf pylauncher*.{e,o}[0-9]* pylauncher_out* None
	@echo "clean test output"
	@/bin/rm -rf pylaunchertest*
totalclean :: clean
	@rm -f ${CPROGRAMS}
