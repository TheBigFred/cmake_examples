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

# ==============================================================================
# == Define the project targets
# ==============================================================================

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
# == Install Directives
# ==============================================================================

include(install)

