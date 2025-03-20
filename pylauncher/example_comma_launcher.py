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

example="comma"
commandlines = "commalines"
if not os.path.exists(commandlines):
    raise Exception( f"input does not exist: {commandlines}" )
print( f"Script: {example}_launcher\n .. running: ClassicLauncher" )
print( f" .. input: {commandlines}\n" )

pylauncher.ClassicLauncher\
    ( commandlines,
      # optional spec of output dir:
      workdir=f"pylauncher_tmp_{example}_{ os.environ['SLURM_JOBID'] }",
      debug="host+exec+task+job")
