cmake_minimum_required(VERSION 3.12)
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for Adios2 testing"
  VERSION 1.0 )

find_package(MPI)
find_package(ADIOS2 REQUIRED)

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp)
target_link_libraries( ${PROJECTNAME} adios2::cxx11_mpi MPI::MPI_C )

add_custom_command(
  TARGET ${PROJECTNAME}
  POST_BUILD
  COMMAND ldd ARGS ${PROJECTNAME}
  COMMENT "ldd on executable:"
)

install(TARGETS ${PROJECTNAME} DESTINATION . )
