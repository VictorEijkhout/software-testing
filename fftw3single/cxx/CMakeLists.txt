cmake_minimum_required( VERSION 3.28 )
project( ${PROJECTNAME}
  DESCRIPTION "C++ programs for FFTW3 testing"
  VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cxx )

find_package( MPI REQUIRED )
find_package( FFTW REQUIRED fftw3 )

message( STATUS "Fftw3 includes: ${FFTW3_INCLUDE_DIRS}" )
message( STATUS "Fftw3 libraries: ${FFTW3_LIBRARY_DIRS}" )

target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_INCLUDE_DIRS} 
        ${FFTW3_INCLUDE_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${MPI_C_LIBRARIES} 
        fftw3::fftw3
	)
target_link_directories(
        ${PROJECTNAME} PUBLIC
	${FFTW3_LIBRARY_DIRS} )
target_link_libraries(
        ${PROJECTNAME} PUBLIC fftw3 )

install( TARGETS ${PROJECTNAME} DESTINATION . )
