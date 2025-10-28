#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"


for siestarun in 'save_outs' 'save_init_rho' 's_only' 'write_ncdf' 'denchar'
do
  mkdir $siestarun
  cd $siestarun

  ln -s ../O.psf  .
  ln -s ../H.psf  .
  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done


siestarun='kp_file'
mkdir $siestarun
cd $siestarun

cp ../../$siestarun.KP .
$SIESTA < ../../$siestarun.fdf > $siestarun.out

cd ..

siestarun='save_dm'
mkdir $siestarun
cd $siestarun

cp ../../$siestarun.DM .
$SIESTA < ../../$siestarun.fdf > $siestarun.out

cd ..
