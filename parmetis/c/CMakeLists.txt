cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )

set( PARMETIS_INCLUDE_DIRS $ENV{TACC_PARMETIS_INC} )
set( PARMETIS_LIBRARY_DIRS $ENV{TACC_PARMETIS_LIB} )
set( PARMETIS_LIBRARIES    "libparmetis.so;libmetis.so" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${PARMETIS_INCLUDE_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${PARMETIS_LIBRARIES}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${PARMETIS_LIBRARY_DIRS}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC parmetis
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
