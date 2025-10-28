#!/bin/sh
#
# cmp_digest -- Generates and compares the digests of two Siesta output files
#               It uses a simple-minded scheme
#
# If only one file is given, the reference is sought in a standard directory which
# must exist (it is linked to by newer versions of Siesta). It can be re-defined
# by setting the environment variable REFERENCE_DIR.
#
# If any differences are found, a file 'OUT.diffs' is left in the
# working directory.
#
# A. Garcia, March 14, 2011. Modified by F. Pedron 2023.
#
# ------------------------------------------ 
# Get absolute path of this script
#
srcdir=$(
cd -P -- "$(dirname -- "$0")" &&
pwd -P
)
if [ -z "${SCRIPTS_DIR}" ] ; then
    SCRIPTS_DIR=$srcdir
fi

# Find all files needed for comparison.
DIGEST_CREATOR=${SCRIPTS_DIR}/out_digest.awk
if [ ! -r $DIGEST_CREATOR ]; then
  echo "ERROR: Digest creator not found in $DIGEST_CREATOR."
  exit 1
fi

if [ $# = 2 ]
then
    f1=$1
    f2=$2
else 
    echo "Usage: [ SCRIPTS_DIR=Dir ] $0 file1.out file2.out"
    exit 1
fi

if [ ! -r $f1 ] ; then echo "ERROR: No such file: $f1"; exit 1 ; fi
if [ ! -r $f2 ] ; then echo "ERROR: No reference file: $f2"; exit 1 ; fi


# Start comparison
echo "Using $DIGEST_CREATOR to compare $1 and $2..."
rm -f .tmp_dig1 .tmp_dig2


# Extract info and compress whitespace
awk -f $DIGEST_CREATOR $f1  > .tmp_dig1
awk -f $DIGEST_CREATOR $f2  > .tmp_dig2

# Get the diffs side-by-side, ignoring whitespace
diff -y -w --suppress-common-lines .tmp_dig1 .tmp_dig2 > OUT.diffs

# Erase the diff file if it is empty
if [ ! -s OUT.diffs ]
then
    echo "Test passed for $f1"
    rm -f OUT.diffs .tmp_dig1 .tmp_dig2
    exit 0
else
    echo "$f1: ** DIFFERENCES FOUND **"
    echo "DIFFS"
    cat OUT.diffs
    exit 1
fi
