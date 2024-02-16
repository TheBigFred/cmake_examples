################################################################################
## File      : dependencies.cmake
## Contents  : cmake package configuration file
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

if (VCPKG_BUILD OR PROJECT_IS_TOP_LEVEL)

  find_package(libb REQUIRED)

endif()

list(APPEND DEP_LIBS
  libB
)
