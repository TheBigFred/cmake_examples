################################################################################
## File      : CMakeLists.txt
## Contents  : Simple lib
##               with sources in subfolder src
##               without dependency
##               with symbols visibility
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

# ==============================================================================
# == Define the project target
# ==============================================================================

add_library(${PROJECT_NAME})


# ==============================================================================
# == src folder files
# ==============================================================================

list(APPEND PRI_INC_FILES

)

list(APPEND PUB_INC_FILES
   ${PROJECT_BINARY_DIR}/src/${PROJECT_NAME}/logger.h
   ${PROJECT_BINARY_DIR}/src/${PROJECT_NAME}/version.h
   lib.h
)

target_sources(${PROJECT_NAME}
    PRIVATE
      ${PRI_INC_FILES}
      ${PUB_INC_FILES}
      ${PROJECT_BINARY_DIR}/logger.cpp
      ${PROJECT_BINARY_DIR}/version.cpp
      lib.cpp
)


# ==============================================================================
# == Include Sub Folders
# ==============================================================================

list(APPEND priSubFolders
   priSubModule
)

list(APPEND pubSubFolders
   pubSubModule
)

foreach(item ${priSubFolders} ${pubSubFolders})
   add_subdirectory(${item})
endforeach(item)


# ==============================================================================
# == Build flags
# ==============================================================================

include(build_flags)
set_build_flags(${PROJECT_NAME})


# ==============================================================================
# == Generate files
# ==============================================================================

include(gen_files)


# ==============================================================================
# == Linker
# ==============================================================================


# ==============================================================================
# == Strip symboles
# ==============================================================================

include(strip_symboles)
strip_symboles(${PROJECT_NAME})


# ==============================================================================
# == Install Directives
# ==============================================================================

include(install)

