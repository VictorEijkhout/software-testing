cmake_minimum_required( VERSION 3.12 )
project( ${PROJECTNAME}
  DESCRIPTION "Fortran programs for CF??? testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.c )

find_package( MPI )
find_package( PkgConfig REQUIRED )
pkg_check_modules( FFTW3 REQUIRED fftw3f )

message( STATUS "Fftw3 includes: ${FFTW3_INCLUDE_DIRS}" )
message( STATUS "Fftw3 libraries: ${FFTW3_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${FFTW3_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        ${FFTW3_LIBRARIES} )
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${FFTW3_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC fftw3f )

install( TARGETS ${PROJECTNAME} DESTINATION . )
