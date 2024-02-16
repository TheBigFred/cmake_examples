################################################################################
## File      : CMakeLists.txt
## Contents  : 
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

cmake_minimum_required(VERSION 3.19 FATAL_ERROR)

project(Demo1 VERSION 0.0.0)

enable_testing()

add_subdirectory(libA)
add_subdirectory(libB)
add_subdirectory(App)

if (PROJECT_IS_TOP_LEVEL)
   list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cpack)
   include(cpack_)
endif()
