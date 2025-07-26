cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( MPI REQUIRED )

# target_include_directories(
# 	${PROJECTNAME} PUBLIC 
# 	${MPI_C_INCLUDE_DIRS}
# 	)
# target_link_directories(
# 	${PROJECTNAME} PUBLIC 
# 	)
target_link_libraries(
	${PROJECTNAME} PUBLIC
	MPI::MPI_C
	# ${MPI_C_LIBRARIES} 
	)
## set_target_properties(
## 	${PROJECTNAME} PROPERTIES
## 	BUILD_RPATH   "${FMTLIB_LIBRARY_DIRS}"
## 	INSTALL_RPATH "${FMTLIB_LIBRARY_DIRS}"
##     )

install( TARGETS ${PROJECTNAME} DESTINATION . )
