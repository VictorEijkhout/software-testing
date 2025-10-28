#!/bin/bash

mkdir work
cd work
cp -r *.* .

. ../../set_siesta_dir.sh "$1" $2


echo "Running script with SIESTA=$SIESTA"

# This script first performs normal MD runs, and then tests for restart files.
for siestarun in 'verlet' 'anneal' 'anneal_pt' 'nose' 'pr' 'npr' 'npr_rip'
do
  mkdir $siestarun
  cd $siestarun

  $SIESTA < ../../$siestarun.fdf > $siestarun.out

  cd ..
done


# Then here we do the restarts.
for siestarun in 'verlet' 'anneal' 'anneal_pt' 'nose' 'pr' 'npr' 'npr_rip'
do
  mkdir ${siestarun}_restart
  cd ${siestarun}_restart
  cp ../../${siestarun}.XV .
  cp ../../*RESTART .

  $SIESTA < ../../$siestarun.fdf > ${siestarun}_rst.out

  cd ..
done

# Here we only use the XV as restart.
# Then here we do the restarts.
for siestarun in 'verlet' 'anneal' 'anneal_pt' 'nose' 'pr' 'npr' 'npr_rip'
do
  mkdir ${siestarun}_half_restart
  cd ${siestarun}_half_restart
  cp ../../${siestarun}.XV .

  $SIESTA < ../../$siestarun.fdf > ${siestarun}_rstxv.out

  cd ..
done
