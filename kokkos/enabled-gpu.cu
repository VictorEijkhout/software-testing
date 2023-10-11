/* %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%
   %%%% This program file is part of the book and course
   %%%% "Parallel Computing"
   %%%% by Victor Eijkhout, copyright 2013-2023
   %%%%
   %%%% enabled.cxx : print what's enabled
   %%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
*/

#include <iostream>
using std::cout;
#include "Kokkos_Core.hpp"

int main(int argc,char **argv) {
  Kokkos::initialize(argc,argv);

#ifdef KOKKOS_ENABLE_SERIAL
  cout << "Serial enabled\n";
#else
  cout << "Serial not enabled\n";
#endif
#ifdef KOKKOS_ENABLE_OPENMP
  cout << "Openmp enabled\n";
#else
  cout << "Openmp not enabled\n";
#endif
#ifdef KOKKOS_ENABLE_CUDA
  cout << "Cuda enabled\n";
#else
  cout << "Cuda not enabled\n";
#endif
#ifdef KOKKOS_ENABLE_HIP
  cout << "Hip enabled\n";
#else
  cout << "Hip not enabled\n";
#endif
#ifdef KOKKOS_ENABLE_THREADS
  cout << "Threads enabled\n";
#else
  cout << "Threads not enabled\n";
#endif
#ifdef KOKKOS_ENABLE_HPX
  cout << "Hpx enabled\n";
#else
  cout << "Hpx not enabled\n";
#endif

  return 0;
}
