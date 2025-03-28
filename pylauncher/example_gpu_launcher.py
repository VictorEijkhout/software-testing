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
import pylauncher

##
## Emulate the classic launcher, using a one liner
##

example = "GPULauncher"
commandlines = "gpucommandlines"
if not os.path.exists(commandlines):
    raise Exception( f"input does not exist: {commandlines}" )
pylauncher.GPULauncher\
    (commandlines,
     gpuspernode=os.environ['NGPUS'],
     # optional spec of output dir:
     workdir=f"pylauncher_tmp_{example}_{ os.environ['SLURM_JOBID'] }",
     debug="ssh+host+exec+job")

