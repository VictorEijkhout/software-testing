cmake_minimum_required( VERSION 3.20 )
project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

target_include_directories(
  ${PROJECTNAME} PUBLIC
  ${SILO_INC}
)

# it's silo5 on s3 & vista
# and now it's siloh5 on s3...
#
# libstdc++ was added for ls6. always needed for C?
#
target_link_libraries(
  ${PROJECTNAME} PUBLIC
  ${SILO_LIB}/libsiloh5.so libstdc++.so libm.so
)

find_package( PkgConfig REQUIRED )
pkg_check_modules( HDF5 REQUIRED hdf5 )
message( STATUS "Hdf5 includes: ${HDF_INCLUDE_DIRS}" )
target_link_libraries(
    ${PROJECTNAME} PUBLIC
    ${HDF5_C_LIBRARIES} ${HDF5_HL_LIBRARIES}
    )
  
# find_library( SILO REQUIRED )
# target_link_libraries(
#   ${PROJECTNAME} PUBLIC
#   SILO
#   )

install( TARGETS ${PROJECTNAME} DESTINATION . )
