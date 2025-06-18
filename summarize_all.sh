#!/bin/bash

for p in \
    adios2 arpack aspect autoconf boost catch2 \
    cfitsio cxxopts dealii eigen fftw2 fftw3   \
    gsl hypre jsonc libmesh metis mfem     \
    netcdf parallelnetcdf pnetcdf              \
    octopus p4est pcre2 scotch ptscotch        \
    siesta silo sqlite3 suitesparse sundials    \
    swig sz trilinos zlib                      \
    ; do 
    ( cd $p && ../summarize_package.sh )
done

# packages with multiple versions
( cd hdf5 && ../summarize_package.sh )
( cd hdf5 && ../summarize_package.sh -v 1.14.3 )

( cd kokkos && ../summarize_package.sh -v 4.6.01-omp )
( cd kokkos && ../summarize_package.sh -v 4.6.01-cuda )
( cd kokkos && ../summarize_package.sh -v 4.6.01-sycl )
