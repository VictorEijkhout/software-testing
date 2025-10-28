#!/bin/bash

LUA=lua
siestarun=flos_h2o_fire

if [ -z $LUA_PATH ]
then
  echo "Define environment variable for LUA_PATH, which must include flos."
fi

. ../../set_siesta_dir.sh "$1" $2

rm -r work
mkdir work
cd work
cp -r *.* .

echo "Running script with SIESTA=$SIESTA"

cp ../relax.lua .
$SIESTA < ../$siestarun.fdf > $siestarun.out
