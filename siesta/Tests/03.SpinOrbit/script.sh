#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

for siestarun in "FePt-X-X" "FePt-offsite" "FePt-onsite"
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done

