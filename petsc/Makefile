TESTS = sanity_tacc sanity_work mumpsi64 hdf5_tacc hdf5_work
TEST = mumpsi64
include ../Make.common

.PHONY: sync
sync :
	@tests=../../Software/petsc/test_versions.txt \
	 && if [ -f $$tests ] ; then \
	      rsync $${tests} . \
	    ; fi

.PHONY: work tacc
work :
	echo "ERROR rule unimplemented"

clean ::
	@rm -f viewhdf5.dat

