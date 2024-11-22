cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME} VERSION 1.0 )
enable_language( Fortran )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90 )

# https://cmake.org/cmake/help/latest/module/FindLAPACK.html
find_package( LAPACK REQUIRED )
if( ${LAPACK_FOUND} ) 
  message( STATUS "Found lapack: ${LAPACK_INCLUDE_DIRS}" )
endif()

target_include_directories(
	${PROJECTNAME} PUBLIC
	${LAPACK95_LIBRARIES}
	)
target_link_libraries(
	${PROJECTNAME} PUBLIC
	LAPACK::LAPACK
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
