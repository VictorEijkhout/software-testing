/****************************************************************
 ****
 **** This program file is part of the tutorial
 **** `Introduction to the PETSc library'
 **** by Victor Eijkhout eijkhout@tacc.utexas.edu
 ****
 **** copyright Victor Eijkhout 2012-2024
 ****
 **** fft.c : demonstrate MatFFT
 ****
 ****************************************************************/

#include <stdlib.h>
#include <stdio.h>
#include <math.h>

static char help[] = "\nFFT example.\n\n";

#include <petscmat.h>
#include <petscvec.h>

#if !defined(PETSC_HAVE_FFTW)
#error Petsc was built without fftw3
#endif

int main(int argc,char **argv)
{
  Vec            x,y;               /* vectors */
  int nprocs,procid;
  PetscErrorCode ierr;

  PetscInitialize(&argc,&argv,(char*)0,help);
  MPI_Comm comm = PETSC_COMM_WORLD;
  MPI_Comm_size(comm,&nprocs);
  MPI_Comm_rank(comm,&procid);
  
  PetscInt Nlocal = 10, Nglobal = Nlocal*nprocs;
  PetscPrintf(comm,"FFT examples on N=%d n=%d\n",Nglobal,Nlocal);

  Mat transform;
  int dimensionality=1;
  PetscInt dimensions[dimensionality]; dimensions[0] = Nglobal; 
  PetscPrintf(comm,"Creating fft D=%d, dim=%d\n",dimensionality,dimensions[0]);
  PetscCall( MatCreateFFT(comm,dimensionality,dimensions,MATFFTW,&transform) );
  {
    PetscInt fft_i,fft_j;
    PetscCall( MatGetSize(transform,&fft_i,&fft_j) );
    PetscPrintf(comm,"FFT global size %d x %d\n",fft_i,fft_j);
  }
  Vec signal,frequencies;
  PetscCall( MatCreateVecsFFTW(transform,&frequencies,&signal,NULL) );
  PetscCall( PetscObjectSetName((PetscObject)signal,"signal") );
  PetscCall( PetscObjectSetName((PetscObject)frequencies,"frequencies") );
  PetscCall( VecAssemblyBegin(signal) );
  PetscCall( VecAssemblyEnd(signal) );
  {
    PetscInt nlocal,nglobal;
    PetscCall( VecGetLocalSize(signal,&nlocal) );
    PetscCall( VecGetSize(signal,&nglobal) );
    PetscCall( PetscPrintf(comm,"Signal local=%d global=%d\n",nlocal,nglobal) );
  }

  PetscInt myfirst,mylast;
  PetscCall( VecGetOwnershipRange(signal,&myfirst,&mylast) );
  printf("Setting %d -- %d\n",myfirst,mylast);
  for (PetscInt vecindex=0; vecindex<Nglobal; vecindex++) {
    PetscScalar
      pi = 4. * atan(1.0),
      h = 1./Nglobal,
      phi = 2* pi * vecindex * h, 
      puresine = cos( phi )
#if defined(PETSC_USE_COMPLEX)
      + PETSC_i * sin(phi)
#endif
      ;
    PetscCall( VecSetValue(signal,vecindex,puresine,INSERT_VALUES) );
  }
  PetscCall( VecAssemblyBegin(signal) );
  PetscCall( VecAssemblyEnd(signal) );

  //codesnippet vecviewbeforeafter
  PetscCall( VecView(signal,PETSC_VIEWER_STDOUT_WORLD) );
  PetscCall( MatMult(transform,signal,frequencies) );
  PetscCall( VecScale(frequencies,1./Nglobal) );
  PetscCall( VecView(frequencies,PETSC_VIEWER_STDOUT_WORLD) );
  //codesnippet end

  {
    //codesnippet fftaccuracy
    Vec confirm;
    PetscCall( VecDuplicate(signal,&confirm) );
    PetscCall( MatMultTranspose(transform,frequencies,confirm) );
    PetscCall( VecAXPY(confirm,-1,signal) );
    PetscReal nrm;
    PetscCall( VecNorm(confirm,NORM_2,&nrm) );
    PetscPrintf(MPI_COMM_WORLD,"FFT accuracy %e\n",nrm);
    PetscCall( VecDestroy(&confirm) );
    //codesnippet end
  }

  PetscCall( MatDestroy(&transform) );
  PetscCall( VecDestroy(&signal) );
  PetscCall( VecDestroy(&frequencies) );

  return PetscFinalize();
}
