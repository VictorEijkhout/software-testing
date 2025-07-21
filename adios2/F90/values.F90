program adios2_values
    use mpi
    use adios2
    implicit none
    integer, parameter :: numsteps = 5
    integer :: ierr
    ! ADIOS2 variables
    type(adios2_adios) :: adios

    ! MPI then ADIOS2 initialization
    call mpi_init(ierr)
    call adios2_init(adios, MPI_COMM_WORLD, ierr)

    ! call writer()
    ! call reader()

    ! ADIOS2 then MPI finalization
    call adios2_finalize(adios, ierr)
    call mpi_finalize(ierr)

end program adios2_values
