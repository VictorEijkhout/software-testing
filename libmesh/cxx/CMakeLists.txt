cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx)
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( LIBMESH REQUIRED libmesh )
message( STATUS "Libmesh includes: ${LIBMESH_INCLUDE_DIRS}" )
message( STATUS "Libmesh library dirs: ${LIBMESH_LIBRARY_DIRS}" )
message( STATUS "Libmesh libraries: ${LIBMESH_LIBRARIES}" )
# other dependencies
pkg_check_modules( HDF REQUIRED hdf5 )
pkg_check_modules( PETSC REQUIRED petsc )
find_package( OpenMP )
find_package( Boost )

target_include_directories(
        ${PROJECTNAME} PUBLIC
	${Boost_INCLUDE_DIRS}
        ${LIBMESH_INCLUDE_DIRS}
	)

target_link_directories(
  ${PROJECTNAME} PUBLIC
  ${Boost_LIBRARY_DIRS}
  ${LIBMESH_LIBRARY_DIRS}
  ${HDF_LIBRARY_DIRS}
  ${PETSC_LIBRARY_DIRS}
  )

target_link_libraries(
  ${PROJECTNAME} PUBLIC
  Boost::boost 
  ${LIBMESH_LIBRARIES}
  ${HDF_LIBRARIES}
  ${PETSC_LIBRARIES}
  OpenMP::OpenMP_CXX
  )
	  
add_custom_command(
  TARGET ${PROJECTNAME}
  POST_BUILD
  COMMAND ldd ARGS ${PROJECTNAME}
  COMMENT "ldd on executable:"
)

install( TARGETS ${PROJECTNAME} DESTINATION . )
