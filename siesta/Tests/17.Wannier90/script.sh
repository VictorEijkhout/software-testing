#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in 'w90-on-the-fly' 'graphene_w90'      #     'w90-chem-h2' up to 2 MPI procs...
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done

