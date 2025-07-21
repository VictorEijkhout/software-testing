cmake_minimum_required(VERSION 3.12)
project( ${PROJECTNAME} )

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
