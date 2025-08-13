cmake_minimum_required(VERSION 3.12)
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for Adios2 testing"
)
enable_language( Fortran )

find_package(MPI)
find_package(ADIOS2 REQUIRED)

add_executable( ${PROJECTNAME} ${PROJECTNAME}.F90)
## https://github.com/ornladios/ADIOS2/issues/4585
target_link_libraries(
  ${PROJECTNAME}
  adios2::fortran_mpi 
  MPI::MPI_Fortran )

add_custom_command(
  TARGET ${PROJECTNAME}
  POST_BUILD
  COMMAND ldd ARGS ${PROJECTNAME}
  COMMENT "ldd on executable:"
)

install(TARGETS ${PROJECTNAME} DESTINATION . )
