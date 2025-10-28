#!/bin/bash

IPI=i-pi
siestarun=h2o-ipi

. ../../set_siesta_dir.sh "$1" $2

rm -r work
mkdir work
cd work
cp -r *.* .

echo "Running script with SIESTA=$SIESTA"

cp ../$siestarun.xml .
cp ../h2o-init.pdb .

$IPI $siestarun.xml &
$SIESTA < ../$siestarun.fdf > $siestarun.out

