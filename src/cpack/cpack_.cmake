################################################################################
## File      : cpack_.cmake
## Contents  : CPack configuration
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

set(CPACK_PACKAGE_NAME   "${PROJECT_NAME}-${PROJECT_VERSION}")
set(CPACK_PACKAGE_VENDOR "TheBigFred")

#set(CPACK_PACKAGE_DESCRIPTION_FILE    "${CMAKE_CURRENT_LIST_DIR}/...")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Simple lib cmake demo")
set(CPACK_RESOURCE_FILE_LICENSE       "${CMAKE_CURRENT_LIST_DIR}/LICENSE")
set(CPACK_RESOURCE_FILE_README        "${CMAKE_CURRENT_LIST_DIR}/README")
set(CPACK_PACKAGING_INSTALL_PREFIX    "")
set(CPACK_OUTPUT_FILE_PREFIX          ${CMAKE_BINARY_DIR}/package)

set(CPACK_PACKAGE_VERSION_MAJOR "${PROJECT_VERSION_MAJOR}")
set(CPACK_PACKAGE_VERSION_MINOR "${PROJECT_VERSION_MINOR}")
set(CPACK_PACKAGE_VERSION_PATCH "${PROJECT_VERSION_PATCH}")

set(CPACK_SOURCE_IGNORE_FILES "${PROJECT_BINARY_DIR};/.git/;.gitignore;.svn")

set(CPACK_COMPONENTS_ALL 
   App_runtime
   App_library
   App_debug
   App_doc
   libA_runtime
   libA_library
   libA_archive
   libA_headers
   libA_cmake
   libA_debug
   libA_doc
   libB_runtime
   libB_library
   libB_archive
   libB_headers
   libB_cmake
   libB_debug
   libB_doc
)
set(CPACK_COMPONENTS_GROUPING ONE_PER_GROUP)

set(CPACK_COMPONENT_APP_RUNTIME_GROUP   RUNTIME)
set(CPACK_COMPONENT_APP_LIBRARY_GROUP   RUNTIME)
set(CPACK_COMPONENT_LIBA_RUNTIME_GROUP  RUNTIME)
set(CPACK_COMPONENT_LIBA_LIBRARY_GROUP  RUNTIME)
set(CPACK_COMPONENT_LIBB_RUNTIME_GROUP  RUNTIME)
set(CPACK_COMPONENT_LIBB_LIBRARY_GROUP  RUNTIME)

set(CPACK_COMPONENT_LIBA_ARCHIVE_GROUP  DEVEL)
set(CPACK_COMPONENT_LIBA_HEADERS_GROUP  DEVEL)
set(CPACK_COMPONENT_LIBA_CMAKE_GROUP    DEVEL)
set(CPACK_COMPONENT_LIBB_ARCHIVE_GROUP  DEVEL)
set(CPACK_COMPONENT_LIBB_HEADERS_GROUP  DEVEL)
set(CPACK_COMPONENT_LIBB_CMAKE_GROUP    DEVEL)

set(CPACK_COMPONENT_APP_DOC_GROUP       DEVEL)
set(CPACK_COMPONENT_LIBA_DOC_GROUP      DEVEL)
set(CPACK_COMPONENT_LIBB_DOC_GROUP      DEVEL)

set(CPACK_COMPONENT_APP_DEBUG_GROUP     DEBUG)
set(CPACK_COMPONENT_LIBA_DEBUG_GROUP    DEBUG)
set(CPACK_COMPONENT_LIBB_DEBUG_GROUP    DEBUG)


include(cpack_archive)
#include(cpack_deb)
#include(cpack_rpm)
#include(cpack_nsis)

include(CPack)
file(WRITE ${CPACK_OUTPUT_FILE_PREFIX}/version.txt ${PROJECT_VERSION})
