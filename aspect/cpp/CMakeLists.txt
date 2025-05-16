cmake_minimum_required(VERSION 3.31.5)

project( ${PROJECTNAME} VERSION 1.0 )

add_executable( ${PROJECTNAME} ${PROJECTNAME}.cpp )

find_package( MPI )
find_package( deal.II REQUIRED )
find_package( aspect REQUIRED )

