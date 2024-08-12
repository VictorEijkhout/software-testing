#!/usr/bin/env python
################################################################
####
#### This file is part of the `pylauncher' package
#### for parametric job launching
####
#### Copyright Victor Eijkhout 2010-2024
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

# SLURM_NTASKS_PER_NODE=56
# SLURM_TASKS_PER_NODE=56
# SLURM_JOB_CPUS_PER_NODE=56
# SLURM_CPUS_ON_NODE

pylauncher.ClassicLauncher\
    ("corelines",
     # optional spec of output dir:
     workdir=f"pylauncher_tmp_node_{ os.environ['SLURM_JOBID'] }",
     cores=os.environ['SLURM_CPUS_ON_NODE'],
     debug="ssh+host+exec+task+job")
