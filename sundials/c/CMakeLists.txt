cmake_minimum_required(VERSION 3.31.5)

project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )
find_package( SUNDIALS REQUIRED )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
	# there are many of these targets;
	# these are just for this example.
	SUNDIALS::cvode SUNDIALS::nvecparallel
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
