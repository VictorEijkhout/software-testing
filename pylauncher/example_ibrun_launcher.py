#!/usr/bin/env python
################################################################
####
#### This file is part of the `pylauncher' package
#### for parametric job launching
####
#### Copyright Victor Eijkhout 2010-2022
#### eijkhout@tacc.utexas.edu
####
#### https://github.com/TACC/pylauncher
####
#### Example of the pylauncher with MPI jobs.
####
################################################################

import pylauncher 

##
## spawn a bunch of MPI parallel jobs, with a core count
## that is constant, specified here.
##
print( f"IbrunLauncher run on pylauncher version {pylauncher.pylauncher_version}" )
pylauncher.IbrunLauncher\
    ("parallellines",cores=3,
     workdir=f"pylauncher_tmp_ibrun",
     debug="job+host+task+exec")
