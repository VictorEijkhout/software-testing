#!/usr/bin/env python
################################################################
####
#### This file is part of the `pylauncher' package
#### for parametric job launching
####
#### Copyright Victor Eijkhout 2010-2025
#### eijkhout@tacc.utexas.edu
####
#### https://github.com/TACC/pylauncher
####
################################################################

import os
import pylauncher as launcher

##
## Emulate the classic launcher, using a one liner
##

example="resume"
print( f"Script: ${example}\n .. running: ClassicLauncher" )
print( " .. input: queuestate314\n" )

launcher.ClassicLauncher\
    ("queuestate314",
     resume=1,
     workdir=f"pylauncher_tmp_${example}_{ os.environ['SLURM_JOBID'] }",
     debug="host+exec+job")

