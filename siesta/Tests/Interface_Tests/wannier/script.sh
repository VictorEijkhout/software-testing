#!/bin/bash

WANNIER=wannier90.x
siestarun=wannier

. ../../set_siesta_dir.sh "$1" $2

rm -r work
mkdir work
cd work
cp -r *.* .

echo "Running script with SIESTA=$SIESTA"

cp ../$siestarun.nnkp .
cp ../$siestarun.win  .
$SIESTA < ../$siestarun.fdf > $siestarun.out
$WANNIER
