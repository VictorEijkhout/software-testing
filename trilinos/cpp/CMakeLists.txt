cmake_minimum_required(VERSION 3.16)
project( ${PROJECTNAME} CXX)

# Adjust if you need a newer dialect
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Point CMAKE_PREFIX_PATH to your Trilinos install prefix if needed
#   cmake -D CMAKE_PREFIX_PATH=/path/to/trilinos ...

find_package(Trilinos REQUIRED)

message(STATUS "Found Trilinos in: ${Trilinos_DIR}")
message(STATUS "Trilinos packages: ${Trilinos_PACKAGE_LIST}")
message(STATUS "Trilinos TPLs:     ${Trilinos_TPL_LIST}")

add_executable(${PROJECTNAME})
target_sources( ${PROJECTNAME} PRIVATE ${PROJECTNAME}.cpp)

# Classic include + link using exported variables (robust across many Trilinos builds)
target_include_directories(${PROJECTNAME} PRIVATE
  ${Trilinos_INCLUDE_DIRS} ${Trilinos_TPL_INCLUDE_DIRS}
)
target_link_libraries(${PROJECTNAME} PRIVATE
  ${Trilinos_LIBRARIES} ${Trilinos_TPL_LIBRARIES}
)

# If Trilinos exports Kokkos imported targets, this will add them (harmless otherwise).
if(TARGET Trilinos::kokkoscore)
  target_link_libraries(${PROJECTNAME} PRIVATE Trilinos::kokkoscore)
endif()
if(TARGET Trilinos::kokkoscontainers)
  target_link_libraries(${PROJECTNAME} PRIVATE Trilinos::kokkoscontainers)
endif()
