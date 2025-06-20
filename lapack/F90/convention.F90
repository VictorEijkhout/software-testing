Program SiestaReturnConvention
  implicit none
  complex :: c
  complex, dimension(2) :: a = [ 1, 2 ]
  complex :: cdotu
  external :: cdotu
  c=cdotu(2,a(:),1,a(:),1)
end Program SiestaReturnConvention

!!
!! Found in:
!! siesta/build/_deps/wrapper-wannier90-src/config/cmake/check_lapack.cmake
!!

! set(CMAKE_REQUIRED_LIBRARIES LAPACK::LAPACK)
! check_fortran_source_runs(
! "
! complex :: c
! complex, dimension(2) :: a = [ 1, 2 ]
! complex :: cdotu
! external :: cdotu
! c=cdotu(2,a(:),1,a(:),1)
! end
! "
! LAPACK_RETURN_CONVENTION_OK SRC_EXT F90)
! unset(CMAKE_REQUIRED_LIBRARIES)
