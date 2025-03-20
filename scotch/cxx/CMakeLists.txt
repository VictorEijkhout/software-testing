cmake_minimum_required( VERSION 3.21 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )
find_package( SCOTCH REQUIRED )

message( STATUS "Include dirs: ${SCOTCH_INCLUDE_DIR}" )
target_include_directories(
        ${PROJECTNAME} PUBLIC
	${SCOTCH_INCLUDE_DIR}
	)
target_link_libraries(
        ${PROJECTNAME} PUBLIC
	${SCOTCH_LIBRARIES}
	)

install( TARGETS ${PROJECTNAME} DESTINATION . )
