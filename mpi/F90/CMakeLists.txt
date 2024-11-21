cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME} VERSION 1.0 )
enable_language( Fortran )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90 )

find_package( MPI REQUIRED )

target_include_directories(
	${PROJECTNAME} PUBLIC 
	${MPI_Fortran_INCLUDE_DIRS}
	)
target_link_directories(
	${PROJECTNAME} PUBLIC 
	)
target_link_libraries(
	${PROJECTNAME} PUBLIC
	${MPI_Fortran_LIBRARIES} 
	)

if( "${USEHDF5}" STREQUAL "ON" ) 

  find_package( HDF5 REQUIRED COMPONENTS C Fortran  )
  if( ${HDF5_FOUND} )
    message( STATUS "Found hdf5: ${HDF5_INCLUDE_DIRS}" )
  else()
    message( FATAL_ERROR "Failed to find hdf5" )
  endif()

  target_link_libraries(
	${PROJECTNAME} PUBLIC
	hdf5::hdf5
	)
endif()

install( TARGETS ${PROJECTNAME} DESTINATION . )
