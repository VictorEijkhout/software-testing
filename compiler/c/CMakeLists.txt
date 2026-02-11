cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for FFTW3 testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} )
target_sources( ${PROJECTNAME} PRIVATE ${PROJECTNAME}.c )

find_package( PkgConfig REQUIRED )

install( TARGETS ${PROJECTNAME} DESTINATION . )
