#
#  This file is part of MUMPS 5.8.0, released
#  on Tue May  6 08:27:40 UTC 2025
#
topdir = ${TACC_PMUMPS_DIR}
libdir = $(topdir)/lib

default: d

.PHONY: default all s d c z multi clean
.SECONDEXPANSION:

all:	c z s d multi

c:	csimpletest csimpletest_save_restore
z:	zsimpletest zsimpletest_save_restore
s:	ssimpletest ssimpletest_save_restore
d:	dsimpletest dsimpletest_save_restore c_example_save_restore c_example
multi:	multiple_arithmetics_example


## maybe in an update
## include $(topdir)/Makefile.inc

LIBSMUMPS = -L$(libdir) -lsmumps -lmumps_common
LIBCMUMPS = -L$(libdir) -lcmumps -lmumps_common
LIBSDMUMPS = -L$(libdir) -lsmumps -ldmumps -lmumps_common
LIBCZMUMPS = -L$(libdir) -lcmumps -lzmumps -lmumps_common

ssimpletest:   $$@.o
	$(FL) -o $@ $(OPTL) ssimpletest.o  $(LIBSMUMPS) $(LORDERINGS) $(LIBS) $(RPATH_OPT) $(LIBBLAS) $(LIBOTHERS)

dsimpletest:  $$@.o 
	$(FL) -o $@ $(OPTL) dsimpletest.o  $(LIBSDMUMPS) $(LORDERINGS) $(LIBS) $(RPATH_OPT) $(LIBBLAS) $(LIBOTHERS)

csimpletest:  $$@.o
	$(FL) -o $@ $(OPTL) csimpletest.o  $(LIBCMUMPS) $(LORDERINGS) $(LIBS) $(RPATH_OPT) $(LIBBLAS) $(LIBOTHERS)

zsimpletest:  $$@.o
	$(FL) -o $@ $(OPTL) zsimpletest.o  $(LIBCZMUMPS) $(LORDERINGS) $(LIBS) $(RPATH_OPT) $(LIBBLAS) $(LIBOTHERS)

c_example: $$@.o
	$(TACC_FC) -fopenmp -o $@ $(OPTL) $@.o $(LIBSDMUMPS) $(LORDERINGS) $(LIBS) $(RPATH_OPT) $(LIBBLAS) $(LIBOTHERS)


multiple_arithmetics_example: $$@.o
	$(FL) -o $@ $(OPTL) $@.o $(LIBSDMUMPS) $(LIBCZMUMPS) $(LORDERINGS) $(LIBS) $(RPATH_OPT) $(LIBBLAS) $(LIBOTHERS)

ssimpletest_save_restore:   $$@.o
	$(FL) -o $@ $(OPTL) ssimpletest_save_restore.o  $(LIBSMUMPS) $(LORDERINGS) $(LIBS) $(LIBBLAS) $(LIBOTHERS)

dsimpletest_save_restore:  $$@.o 
	$(FL) -o $@ $(OPTL) dsimpletest_save_restore.o  $(LIBSDMUMPS) $(LORDERINGS) $(LIBS) $(LIBBLAS) $(LIBOTHERS)

csimpletest_save_restore:  $$@.o
	$(FL) -o $@ $(OPTL) csimpletest_save_restore.o  $(LIBCMUMPS) $(LORDERINGS) $(LIBS) $(LIBBLAS) $(LIBOTHERS)

zsimpletest_save_restore:  $$@.o
	$(FL) -o $@ $(OPTL) zsimpletest_save_restore.o  $(LIBCZMUMPS) $(LORDERINGS) $(LIBS) $(LIBBLAS) $(LIBOTHERS)

c_example_save_restore: $$@.o
	$(FL) -o $@ $(OPTL) $@.o $(LIBSDMUMPS) $(LORDERINGS) $(LIBS) $(LIBBLAS) $(LIBOTHERS)

.SUFFIXES: .c .F .o
.F.o:
	$(FC) $(OPTF) -I. -I$(topdir)/include -I$(topdir)/src $(INCS) -c $*.F $(OUTF)$*.o
## .c.o:
## csimpletest.o : ${SRCDIR}/csimpletest.c
c_example.o : ${SRCDIR}/c_example.c
	$(CC) $(OPTC) $(CDEFS) -I. -I$(topdir)/include -I$(topdir)/src $(INCS) -c $< $(OUTC)$*.o

clean:
	$(RM) *.o [sdcz]simpletest c_example multiple_arithmetics_example ssimpletest_save_restore dsimpletest_save_restore csimpletest_save_restore zsimpletest_save_restore c_example_save_restore
