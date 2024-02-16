################################################################################
## File      : gen_files.cmake
## Contents  : generate files: version .h .cpp .cmake
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

configure_file(
   ${PROJECT_SOURCE_DIR}/cmake/version.h.in
   ${PROJECT_BINARY_DIR}/version.h @ONLY
)
configure_file(
   ${PROJECT_SOURCE_DIR}/cmake/version.cpp.in
   ${PROJECT_BINARY_DIR}/version.cpp @ONLY
)

configure_file(
   ${PROJECT_SOURCE_DIR}/cmake/logger.h.in
   ${PROJECT_BINARY_DIR}/logger.h @ONLY
)
configure_file(
   ${PROJECT_SOURCE_DIR}/cmake/logger.cpp.in
   ${PROJECT_BINARY_DIR}/logger.cpp @ONLY
)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
   ${PROJECT_BINARY_DIR}/${PROJECT_NAME_LC}ConfigVersion.cmake
   VERSION ${PROJECT_VERSION}
   COMPATIBILITY SameMajorVersion
)

configure_package_config_file(
   ${PROJECT_SOURCE_DIR}/cmake/config.cmake.in
   ${PROJECT_BINARY_DIR}/${PROJECT_NAME_LC}Config.cmake
   INSTALL_DESTINATION cmake
)
