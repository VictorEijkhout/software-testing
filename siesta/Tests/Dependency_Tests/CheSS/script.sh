#!/bin/bash

siestarun=CheSS

. ../../set_siesta_dir.sh "$1" $2

rm -r work
mkdir work
cd work
cp -r *.* .

echo "Running script with SIESTA=$SIESTA"

$SIESTA < ../$siestarun.fdf > $siestarun.out
