cmake_minimum_required(VERSION 3.12)
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for HDF55 testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )
target_compile_features( ${PROJECTNAME} PRIVATE cxx_std_17 )

find_package(HDF5 COMPONENTS C HL REQUIRED)
target_include_directories(
    ${PROJECTNAME} PUBLIC
    ${HDF5_INCLUDE_DIRS}
    )

target_link_libraries(
    ${PROJECTNAME} PUBLIC
    ${HDF5_C_LIBRARIES} ${HDF5_HL_LIBRARIES}
    )
