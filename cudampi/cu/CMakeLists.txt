cmake_minimum_required(VERSION 3.10 FATAL_ERROR)
project( ${PROJECTNAME}
  DESCRIPTION "Cu programs for Cuda testing"
  LANGUAGES CXX CUDA)
enable_language( CUDA )

find_package( MPI REQUIRED )

add_executable( ${PROJECTNAME} )
target_sources( ${PROJECTNAME} PRIVATE ${PROJECTNAME}.cu )

# Example: control the GPU architectures to compile for.
# Replace "sm_70" with the architectures relevant to your hardware.
set(CMAKE_CUDA_ARCHITECTURES 70)

target_include_directories(
	${PROJECTNAME} PUBLIC
	${MPI_CXX_INCLUDE_DIRS} ${CMAKE_CURRENT_SOURCE_DIR} )
target_link_libraries(
	${PROJECTNAME} PUBLIC 
	${MPI_CXX_LIBRARIES} )

install( TARGETS ${PROJECTNAME} DESTINATION . )

