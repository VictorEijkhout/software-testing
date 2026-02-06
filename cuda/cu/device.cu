// -*- c++ -*-
/****************************************************************
 ****
 **** This file belongs with the course
 **** Parallel Programming in MPI and OpenMP
 **** copyright 2016-2025 Victor Eijkhout eijkhout@tacc.utexas.edu
 ****
 **** device.cxx : dealing with cuda devices
 ****
 ****************************************************************/

#include <iostream>
using std::cerr;

int main() {

  const int ndev = 
    [] () ->int {
      int ndev;
      cudaError_t status = cudaGetDeviceCount(&ndev);
      if (status==cudaSuccess)
	return ndev;
      else if (status==cudaErrorNoDevice) {
	cerr << "No devices found\n"; throw status;
      } else if (status==cudaErrorInsufficientDriver) {
	cerr << "Insufficient driver\n"; throw status;
      } else {
	cerr << "Unknown cudaError_t: " << status << '\n';
	throw status;
      }
    }();

  cerr << "Number of devices detected: " << ndev << '\n';
  for ( int idev=0; idev<ndev; ++idev ) {
    cudaDeviceProp properties;
    try {
      cudaGetDeviceProperties(&properties,idev);
    } catch (...) {
      cerr << "cudaGetDeviceProperties throws exception" << '\n';
      throw;
    }
    cerr << "Device " << idev << "=" << properties.name << '\n';
    cerr << "  async: " << properties.asyncEngineCount << '\n';
    cerr << "  unified: " << properties.unifiedAddressing << '\n';

    cerr << "  capability: " << properties.major << "." << properties.minor << '\n';
    cerr << "  multiprocs: " << properties.multiProcessorCount << '\n';
    //    cerr << "  clock rate: " << properties.clockRate << '\n';

    cerr << "  global memory: " << properties.totalGlobalMem << '\n';
    cerr << "  shared mem/block: " << properties.sharedMemPerBlock << '\n';

    cerr << "  max threads/block: " << properties.maxThreadsPerBlock << '\n';
    cerr << "  max thread dims: " << properties.maxThreadsDim[0] << ","
	 << properties.maxThreadsDim[1] << "," 
	 << properties.maxThreadsDim[2] << '\n';
  }

#if CUDA_VERSION >= 12000
  try {
    cudaError_t status = cudaInitDevice(0,0,0);
    if (status==cudaSuccess) {
      cerr << "device successfully initialized" << '\n';
    } else {
      cerr << "cudaInitDevice returned " << status << '\n';
      throw;
    }
  } catch (...) {
#endif

  return 0;
}
