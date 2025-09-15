cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "C programs for Phdf5 testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package( PkgConfig REQUIRED )
pkg_check_modules( HDF REQUIRED hdf5 )
message( STATUS "Hdf5 includes: ${HDF_INCLUDE_DIRS}" )

# find_package( HDF5 REQUIRED COMPONENTS C )
# target_link_libraries(
#     ${PROJECTNAME} PUBLIC
#     hdf5::hdf5
# )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${HDF_INCLUDE_DIRS}
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
        ${HDF_LIBRARY_DIRS}
        )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${HDF_LIBRARIES}
	-lpthread
        )

install( TARGETS ${PROJECTNAME} DESTINATION . )
