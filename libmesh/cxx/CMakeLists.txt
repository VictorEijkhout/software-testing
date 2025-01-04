cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx)
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( LIBMESH REQUIRED libmesh )
message( STATUS "Libmesh includes: ${LIBMESH_INCLUDE_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${LIBMESH_INCLUDE_DIRS}
	)

target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${LIBMESH_LIBRARIES}
	)
	  
install( TARGETS ${PROJECTNAME} DESTINATION . )
