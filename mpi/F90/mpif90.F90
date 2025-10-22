Program testmpif90
  use mpi
  implicit none
  Integer :: comm = MPI_COMM_WORLD
  Integer :: nprocs,procno,ierr

  call MPI_Init(ierr)
  call MPI_Comm_size(comm,nprocs,ierr)
  call MPI_Comm_rank(comm,procno,ierr)
  if ( procno==0 ) then
     print *,"Running on: ",nprocs," processes"
  end if
  call MPI_Finalize(ierr)

End Program testmpif90

