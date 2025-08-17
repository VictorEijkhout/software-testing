cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for Scalapack testing"
  VERSION 1.0 )
enable_language( Fortran )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.f90 )

find_package( MPI REQUIRED )
find_package( scalapack REQUIRED )
## https://github.com/Reference-ScaLAPACK/scalapack/issues/109

target_link_libraries(
	${PROJECTNAME} PUBLIC
	scalapack
        ${LAPACK_LIBRARIES}
        ${BLAS_LIBRARIES}
        MPI::MPI_Fortran
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
