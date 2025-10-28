#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

siestarun1='TDDFT_h2o1'
siestarun2='TDDFT_h2o2'

siestarun=$siestarun1
mkdir $siestarun
cd $siestarun

$SIESTA < ../../$siestarun.fdf > $siestarun.out

cd ..

siestarun=$siestarun2
mkdir $siestarun
cd $siestarun

cp ../../TDDFT_h2o.TDWF .
cp ../../TDDFT_h2o.TDXV .
cp ../../TDDFT_h2o.XV   .
cp ../../TDDFT_h2o.DM   .
$SIESTA < ../../$siestarun.fdf > $siestarun.out

cd ..
