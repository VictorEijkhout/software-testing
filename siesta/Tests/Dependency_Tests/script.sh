#!/bin/bash
rm -r work
mkdir work
cd work
cp -r *.* .
. ../../set_siesta_dir.sh "$1" $2
echo "Running script with SIESTA=$SIESTA"

siestarun=dftd3
mkdir $siestarun
cd $siestarun
$SIESTA < ../../$siestarun.fdf > $siestarun.out
cd ..

LUA=lua
siestarun=lua_h2o
if [ -z $LUA_PATH ]
then
  echo "Define environment variable for LUA_PATH, which must include flos."
fi

mkdir $siestarun
cd $siestarun
cp ../../siesta.lua .
$SIESTA < ../../$siestarun.fdf > $siestarun.out
cd ..