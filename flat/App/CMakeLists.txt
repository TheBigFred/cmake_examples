################################################################################
## File      : CMakeLists.txt
## Contents  : Application using libB with dependency on libA
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

cmake_minimum_required(VERSION 3.21 FATAL_ERROR)

project(App VERSION 0.0.0.0 LANGUAGES CXX)
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

option(ENABLE_TEST_${PROJECT_NAME}  "Enable Unit tests"                 OFF)
option(ENABLE_DOC_${PROJECT_NAME}   "Generate Doxygen documentation"    OFF)
include(logger_severity)


# ==============================================================================
# == Define the project targets
# ==============================================================================

set(PROJECT_NAME_OBJ "${PROJECT_NAME}_OBJ")
add_library(${PROJECT_NAME_OBJ} OBJECT )

add_executable(${PROJECT_NAME}
   $<TARGET_OBJECTS:${PROJECT_NAME_OBJ}>
   main.cpp
)


# ==============================================================================
# == Main folder files
# ==============================================================================

target_sources(${PROJECT_NAME_OBJ}
   PRIVATE
      ${PROJECT_BINARY_DIR}/config.h
      ${PROJECT_BINARY_DIR}/logger.h
      ${PROJECT_BINARY_DIR}/logger.cpp
      ${PROJECT_BINARY_DIR}/version.h
      ${PROJECT_BINARY_DIR}/version.cpp
)


# ==============================================================================
# == Include Sub Folders
# ==============================================================================

list(APPEND subFolders
   subModule1
   subModule2
)

foreach(item ${subFolders})
   add_subdirectory(${item})
endforeach(item)


# ==============================================================================
# == Build flags
# ==============================================================================

include(build_flags)
set_build_flags(${PROJECT_NAME}_OBJ)
set_build_flags(${PROJECT_NAME})


# ==============================================================================
# == Generate files
# ==============================================================================

include(gen_files)


# ==============================================================================
# == Linker
# ==============================================================================

include(dependencies)
target_link_libraries(${PROJECT_NAME_OBJ}
   PRIVATE
      ${DEP_LIBS}
)

target_link_libraries(${PROJECT_NAME}
   PRIVATE
      ${DEP_LIBS}
)

# ==============================================================================
# == Strip symboles
# ==============================================================================

include(strip_symboles)
strip_symboles(${PROJECT_NAME})


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


# ==============================================================================
# == Install Directives
# ==============================================================================

include(install)

