cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME} VERSION 1.0 )
enable_language( Fortran )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90 )

## may not work with TN scalpack
## find_package( SCALAPACK REQUIRED )
## https://github.com/Reference-ScaLAPACK/scalapack/issues/109

find_package( PkgConfig REQUIRED )
pkg_check_modules( mpi REQUIRED impi ) # check `impi', publish as `mpi'
pkg_check_modules( scalapack REQUIRED scalapack )

if( ${scalapack_FOUND} ) 
  message( STATUS "Found scalapack, libs=${scalapack_LIBRARIES}" )
else()
  message( FATAL_ERROR "No scalapack found" )
endif()

target_include_directories(
	${PROJECTNAME} PUBLIC
	${scalapack_LIBRARIES}
	)
target_link_directories(
	${PROJECTNAME} PUBLIC
	${scalapack_LIBRARY_DIRS}
	)
target_link_libraries(
	${PROJECTNAME} PUBLIC
	${scalapack_LIBRARIES}
## 	scalapack::scalapack
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
