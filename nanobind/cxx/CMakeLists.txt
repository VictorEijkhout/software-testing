# https://nanobind.readthedocs.io/en/latest/building.html#building

cmake_minimum_required(VERSION 3.15...3.27)
project( ${PROJECTNAME} )
find_package(Python 3.8...3.13 COMPONENTS Interpreter Development.Module REQUIRED)

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Release CACHE STRING "Choose the type of build." FORCE)
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Detect the installed nanobind package and import it into CMake
## execute_process(
##   COMMAND "${Python_EXECUTABLE}" -m nanobind --cmake_dir
##   OUTPUT_STRIP_TRAILING_WHITESPACE OUTPUT_VARIABLE NB_DIR)
## list(APPEND CMAKE_PREFIX_PATH "${NB_DIR}")
find_package(nanobind CONFIG REQUIRED)

# start building an extension
nanobind_add_module( ${PROJECTNAME} ${PROJECTNAME}.cxx )
