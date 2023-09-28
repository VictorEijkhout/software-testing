#include "petsc.h"
#include "petscviewerhdf5.h"

#undef __FUNCT__
#define __FUNCT__ "main"
int main(int argc,char **args)
{
  PetscErrorCode ierr;
  MPI_Comm comm;
  Mat A;
  PetscScalar one = 1.0;
  
  PetscFunctionBegin;
  PetscInitialize(&argc,&args,0,0);

  comm = PETSC_COMM_SELF;
  int nprocs,procno;
  MPI_Comm_size(comm,&nprocs);
  if (nprocs>1) {
    printf("Sequential example only \n"); return 1; }

  int matrix_size = 1; 
  PetscCall( MatCreate(comm,&A) );
  PetscCall( MatSetType(A,MATMPIAIJ) );
  PetscCall( MatSetSizes(A,matrix_size,matrix_size,PETSC_DECIDE,PETSC_DECIDE) );
  PetscCall( MatMPIAIJSetPreallocation(A,5,PETSC_NULLPTR,3,PETSC_NULLPTR) );
  PetscCall( MatSetValue(A,0,0,1.,INSERT_VALUES) );
  PetscCall( MatAssemblyBegin(A,MAT_FINAL_ASSEMBLY) );
  PetscCall( MatAssemblyEnd(A,MAT_FINAL_ASSEMBLY) );

  {
    PetscViewer hdf5viewer;
    PetscCall( PetscViewerHDF5Open(comm,"viewhdf5.dat",FILE_MODE_WRITE,&hdf5viewer) );
    PetscCall( MatView( A,hdf5viewer ) );
    PetscCall( PetscViewerDestroy(&hdf5viewer) );
  }

  {
    PetscViewer hdf5viewer;
    PetscCall( PetscViewerHDF5Open(comm,"viewhdf5.dat",FILE_MODE_READ,&hdf5viewer) );
    PetscCall( MatLoad( A,hdf5viewer ) );
    PetscCall( PetscViewerDestroy(&hdf5viewer) );
  }

  MatDestroy(&A);
  return PetscFinalize();
}

