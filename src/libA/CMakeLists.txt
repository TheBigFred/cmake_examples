################################################################################
## File      : CMakeLists.txt
## Contents  : Simple lib
##               with sources in subfolder src
##               without dependency
##               without symbols visibility
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

cmake_minimum_required(VERSION 3.21 FATAL_ERROR)

project(libA VERSION 0.0.0.0 LANGUAGES CXX)
message(STATUS "##teamcity[buildNumber '${PROJECT_VERSION}']")


# ==============================================================================
# == Setup Modules Path, default cmake flags & vars
# ==============================================================================

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(cmake_flags)

if (PROJECT_IS_TOP_LEVEL)
   include(cpack_)
endif()


# ==============================================================================
# == Options
# ==============================================================================

option(INSTALL_HEADER_ONLY          "Install only header files"         OFF)
option(ENABLE_TEST_${PROJECT_NAME}  "Enable Unit tests"                 OFF)
option(ENABLE_DOC_${PROJECT_NAME}   "Generate Doxygen documentation"    OFF)
include(logger_severity)


# ==============================================================================
# == Add Sources
# ==============================================================================

add_subdirectory(src/${PROJECT_NAME})


# ==============================================================================
# == Optional targets
# ==============================================================================

if (ENABLE_TEST_${PROJECT_NAME})
   enable_testing()
   add_subdirectory(tests)
endif()

if (ENABLE_DOC_${PROJECT_NAME})
   add_subdirectory(docs)
endif()
