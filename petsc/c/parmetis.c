#include "petsc.h"

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

  int matrix_size = 100; 
  PetscCall( MatCreate(comm,&A) );
  PetscCall( MatSetType(A,MATMPIAIJ) );
  PetscCall( MatSetSizes(A,matrix_size,matrix_size,PETSC_DECIDE,PETSC_DECIDE) );
  PetscCall( MatMPIAIJSetPreallocation(A,5,PETSC_NULLPTR,3,PETSC_NULLPTR) );
  for ( int i=0; i<matrix_size; ++i )
    PetscCall( MatSetValue(A,i,i,2.,INSERT_VALUES) );
  for ( int i=0; i<matrix_size-1; ++i ) {
    PetscCall( MatSetValue(A,i,i+1,-1.,INSERT_VALUES) );
    PetscCall( MatSetValue(A,i+1,i,-1.,INSERT_VALUES) );
  }
  PetscCall( MatAssemblyBegin(A,MAT_FINAL_ASSEMBLY) );
  PetscCall( MatAssemblyEnd(A,MAT_FINAL_ASSEMBLY) );

  {
    MatPartitioning part;
    IS              is;
    PetscCall(MatPartitioningCreate(comm, &part));
    PetscCall(MatPartitioningSetAdjacency(part, A));
    PetscCall(MatPartitioningSetType(part, MATPARTITIONINGPARMETIS));
    PetscCall(MatPartitioningHierarchicalSetNcoarseparts(part, 2));
    PetscCall(MatPartitioningHierarchicalSetNfineparts(part, 2));
    PetscCall(MatPartitioningSetFromOptions(part));
    /* get new processor owner number of each vertex */
    PetscCall(MatPartitioningApply(part, &is));
  }

  MatDestroy(&A);
  return PetscFinalize();
}

