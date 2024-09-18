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

import pylauncher

##
## Emulate the classic launcher, using a one liner
##

print( f"ClassicLauncher 11 core test run on pylauncher version {pylauncher.pylauncher_version}" )
pylauncher.ClassicLauncher("commandlines",
                            cores=11,
                            debug="job+host+exec",
                            )
