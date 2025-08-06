cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

enable_language( Fortran )
add_executable( ${PROJECTNAME} ${PROJECTNAME}.f )

find_package( MPI )
# find_package( PkgConfig REQUIRED )
find_package( HYPRE REQUIRED )

message( STATUS "Hypre includes: ${HYPRE_INCLUDE_DIRS}" )
message( STATUS "Hypre library dires: ${HYPRE_LIBRARY_DIRS}" )
message( STATUS "Hypre libraries: ${HYPRE_LIBRARIES}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${HYPRE_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${HYPRE_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${HYPRE_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC m
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
