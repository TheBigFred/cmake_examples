################################################################################
## File      : install.cmake
## Contents  : CMakeLists.txt install section
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

include(GNUInstallDirs)

   # == bin
   install(
      TARGETS
         ${PROJECT_NAME}
      RUNTIME
         DESTINATION    ${CMAKE_INSTALL_BINDIR}
         COMPONENT      ${PROJECT_NAME}_runtime
      LIBRARY
         DESTINATION    ${CMAKE_INSTALL_LIBDIR}
         COMPONENT      ${PROJECT_NAME}_library
      ARCHIVE
         DESTINATION    ${CMAKE_INSTALL_LIBDIR}
         COMPONENT      ${PROJECT_NAME}_archive
   )

   if (NOT MSVC AND BUILD_SHARED_LIBS)

      install(
         FILES
            ${SYMBOLES}
         DESTINATION
            ${CMAKE_INSTALL_BINDIR}
         COMPONENT
            ${PROJECT_NAME}_debug
      )

   endif()

   if (MSVC AND BUILD_SHARED_LIBS)

      set(PDBFILENAME $<IF:$<CONFIG:Debug>,${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_BINDIR}/Debug/${PROJECT_NAME}_d.pdb,${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_BINDIR}/Release/${PROJECT_NAME}.pdb>)
      install(
         FILES
            ${PDBFILENAME}
         DESTINATION
            ${CMAKE_INSTALL_BINDIR}
         CONFIGURATIONS
            Debug
         COMPONENT
            ${PROJECT_NAME}_debug
       )

   endif()

   # == doc
   if (ENABLE_DOC_${PROJECT_NAME})
      install(
         DIRECTORY
            ${PROJECT_SOURCE_DIR}/docs/html
         DESTINATION
            ${CMAKE_INSTALL_DOCDIR}
         COMPONENT
            ${PROJECT_NAME}_doc
      )
   endif()
