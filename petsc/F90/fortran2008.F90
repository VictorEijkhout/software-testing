program hello_world

  use petscksp
  !!  use MPI ! F90 binding
  use mpi_f08 ! F08 binding

  implicit none
  integer ierr, num_procs, rank, i
  integer count, src

  call MPI_INIT ( ierr )
  call MPI_COMM_RANK (MPI_COMM_WORLD, rank, ierr)
  call MPI_COMM_SIZE (MPI_COMM_WORLD, num_procs, ierr)
  print *, "Hello world! My MPI Rank is ", rank, " out of ", num_procs, " processes."
  call MPI_Barrier (MPI_COMM_WORLD, ierr)

  do i = 0, num_procs-1
     if (rank == i .and. rank == 0) then
        print *, "Master proc [", rank, "]"
     else if (rank == i) then
        print *, "Worker proc [", rank, "]"
     else
     endif
  enddo

  call MPI_FINALIZE ( ierr )
  stop

end program hello_world
