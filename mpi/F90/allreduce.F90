! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
!   Copyright by The HDF Group.                                               *
!   All rights reserved.                                                      *
!                                                                             *
!   This file is part of HDF5.  The full HDF5 copyright notice, including     *
!   terms governing use, modification, and redistribution, is contained in    *
!   the COPYING file, which can be found at the root of the source code       *
!   distribution tree, or in https://www.hdfgroup.org/licenses.               *
!   If you do not have access to either file, you may request a copy from     *
!   help@hdfgroup.org.                                                        *
! * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
!
! Tests async Fortran wrappers. It needs an async VOL. It will skip the tests if
! HDF5_VOL_CONNECTOR is not set or is set to a non-supporting async VOL.
!

!! VLE #include <H5config_f.inc>
!! VLE instead, hack:
#define H5_HAVE_MPI_F08

!
! The main program for async HDF5 Fortran tests
!
PROGRAM async_test
  USE, INTRINSIC :: ISO_C_BINDING, ONLY : C_INT64_T
!!  USE test_async_APIs
  USE mpi_f08
  USE hdf5
  
  IMPLICIT NONE

  INTEGER(KIND=MPI_INTEGER_KIND) :: mpierror               ! MPI hdferror flag
  INTEGER(KIND=MPI_INTEGER_KIND) :: mpi_size               ! number of processes in the group of communicator
  INTEGER(KIND=MPI_INTEGER_KIND) :: mpi_rank               ! rank of the calling process in the communicator
  INTEGER(KIND=MPI_INTEGER_KIND) :: required, provided
#ifdef H5_HAVE_MPI_F08
  TYPE(MPI_DATATYPE) :: mpi_int_type
#else
  INTEGER(KIND=MPI_INTEGER_KIND) :: mpi_int_type
#endif

  INTEGER(HID_T) :: vol_id
  INTEGER :: hdferror
  LOGICAL :: registered

!! (kind=mpi_integer8)
  INTEGER :: total_error = 0, sum

  INTEGER :: nerrors = 0
  INTEGER :: len, idx

  CHARACTER(LEN=255) :: vol_connector_string, vol_connector_name
  INTEGER(C_INT64_T) :: cap_flags
  INTEGER(HID_T) :: plist_id
  LOGICAL          :: cleanup
  INTEGER          :: ret_total_error = 0

  !
  ! initialize MPI
  !
  call mpi_init(mpierror)
#if 0
  required = MPI_THREAD_MULTIPLE
  CALL mpi_init_thread(required, provided, mpierror)
  IF (mpierror .NE. MPI_SUCCESS) THEN
     WRITE(*,*) "MPI_INIT_THREAD  *FAILED*"
     nerrors = nerrors + 1
  ENDIF
  IF (provided .NE. required) THEN
     mpi_thread_mult = .FALSE.
  ENDIF
#endif
  
  CALL mpi_comm_rank( MPI_COMM_WORLD, mpi_rank, mpierror )
  IF (mpierror .NE. MPI_SUCCESS) THEN
     WRITE(*,*) "MPI_COMM_RANK  *FAILED* Process = ", mpi_rank
     nerrors = nerrors + 1
  ENDIF
  CALL mpi_comm_size( MPI_COMM_WORLD, mpi_size, mpierror )
  IF (mpierror .NE. MPI_SUCCESS) THEN
     WRITE(*,*) "MPI_COMM_SIZE  *FAILED* Process = ", mpi_rank
     nerrors = nerrors + 1
  ENDIF

  IF(nerrors.NE.0)THEN
     IF(mpi_rank==0) CALL write_test_status(sum, &
          'Testing Initializing mpi_init_thread', total_error)
     CALL MPI_Barrier(MPI_COMM_WORLD, mpierror)
     CALL mpi_abort(MPI_COMM_WORLD, 1_MPI_INTEGER_KIND, mpierror)
  ENDIF

  
  IF(h5_sizeof(total_error).EQ.8_size_t)THEN
     mpi_int_type=MPI_INTEGER8
  ELSE
     mpi_int_type=MPI_INTEGER4
  ENDIF

  CALL MPI_ALLREDUCE(total_error, sum, 1_MPI_INTEGER_KIND, mpi_int_type, MPI_SUM, MPI_COMM_WORLD, mpierror)

  IF(mpi_rank==0) CALL write_test_footer()

  !
  ! close MPI
  !
  IF (sum == 0) THEN
     CALL mpi_finalize(mpierror)
     IF (mpierror .NE. MPI_SUCCESS) THEN
        WRITE(*,*) "MPI_FINALIZE  *FAILED* Process = ", mpi_rank
     ENDIF
  ELSE
     WRITE(*,*) 'Errors detected in process ', mpi_rank
     CALL mpi_abort(MPI_COMM_WORLD, 1_MPI_INTEGER_KIND, mpierror)
     IF (mpierror .NE. MPI_SUCCESS) THEN
        WRITE(*,*) "MPI_ABORT  *FAILED* Process = ", mpi_rank
     ENDIF
  ENDIF

  !
  ! end main program
  !

END PROGRAM async_test
