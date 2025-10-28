#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in 'fe_spin' 'fe_spin_directphi' 'fe_noncol' 'fe_noncol_gga' 'fe_noncol_kp' 'fe_noncol_sp'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done

