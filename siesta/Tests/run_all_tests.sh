#!/bin/bash

for folder in 00.BasisSets 01.PseudoPotentials 02.SpinPolarization 03.SpinOrbit 04.SCFMixing 05.Bands 06.DensityOfStates 07.ForceConstants 08.GeometryOptimization 09.MolecularDynamics 10.Functionals 11.ElectronicProperties 12.Solvers 13.MiscOptions 14.FileIO 15.TDDFT 16.TranSiesta 17.Wannier90 Dependency_Tests

do
  cd $folder

  # Choose your appropriate values for MPI and siesta binary folder. See the README.
  bash script.sh "" ../../../_siesta_bin_serial/bin

  cd ..
done
