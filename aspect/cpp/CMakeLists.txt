cmake_minimum_required(VERSION 3.31.5)

project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI )
# nope find_package( deal.II REQUIRED )
find_package( Aspect REQUIRED )

find_package( PkgConfig REQUIRED )
pkg_check_modules( CATCH2 REQUIRED catch2-with-main )
target_include_directories(
        ${PROJECTNAME} PUBLIC
        ${CATCH2_INCLUDE_DIRS}
        )
target_link_directories(
        ${PROJECTNAME} PUBLIC
        ${CATCH2_LIBRARY_DIRS}
        )
target_link_libraries(
        ${PROJECTNAME} PUBLIC
        ${CATCH2_LIBRARIES}
        )

DEAL_II_INITIALIZE_CACHED_VARIABLES()

ASPECT_SETUP_PLUGIN(${PROJECTNAME})

install( TARGETS ${PROJECTNAME} DESTINATION . )
