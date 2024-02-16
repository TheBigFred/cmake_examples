################################################################################
## File      : build_flags.cmake
## Contents  : set_build_flags cmake function
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

include(GNUInstallDirs)

function(set_build_flags target_name)

   # CFLAGS & CXXFLAGS
   target_compile_options(${target_name}
      PRIVATE
         $<$<CXX_COMPILER_ID:MSVC>:>
         $<$<AND:$<CONFIG:DEBUG>,$<CXX_COMPILER_ID:MSVC>>:>
         $<$<AND:$<CONFIG:RELEASE>,$<CXX_COMPILER_ID:MSVC>>:>

         $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra -fmessage-length=0 -Wl,-whole-archive>
         $<$<AND:$<CONFIG:DEBUG>,$<CXX_COMPILER_ID:GNU>>:-O0 -ggdb>
         $<$<AND:$<CONFIG:RELEASE>,$<CXX_COMPILER_ID:GNU>>:-O3 -ggdb>
   )

   set(lib_prefix lib)
   if (${PROJECT_NAME} MATCHES  "^lib")
      set(lib_prefix "")
   endif()

   set_target_properties(${target_name}
      PROPERTIES
         CXX_STANDARD                 11
         CXX_STANDARD_REQUIRED        YES
         POSITION_INDEPENDENT_CODE    YES
         WINDOWS_EXPORT_ALL_SYMBOLS   ON
         PREFIX                       "${lib_prefix}"
         DEBUG_POSTFIX                "_d"

         ARCHIVE_OUTPUT_DIRECTORY     "${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_LIBDIR}"
         LIBRARY_OUTPUT_DIRECTORY     "${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_LIBDIR}"
         RUNTIME_OUTPUT_DIRECTORY     "${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_BINDIR}"
   )

   if (BUILD_SHARED_LIBS)
      set_target_properties(${target_name}
         PROPERTIES
            SOVERSION                  ${PROJECT_VERSION_MAJOR}
            VERSION                    ${PROJECT_VERSION}
      )
   endif()

   # -D
   target_compile_definitions(${target_name}
      PUBLIC
         $<$<CONFIG:DEBUG>:_DEBUG=1>
         $<$<CONFIG:RELEASE>:NDEBUG=1>
   )

   if (DEFINED ${LOGGER_SEV_${PROJECT_NAME}})
      target_compile_definitions(${target_name}
         PUBLIC
         LOGGER_MIN_SEVERITY=LOGGER_SEV_${PROJECT_NAME}
      )
   endif()

   # -I
   target_include_directories(${target_name}
      PRIVATE
         $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src/${PROJECT_NAME}>
      PUBLIC
         $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/src>
         $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/src>
         $<INSTALL_INTERFACE:include>
   )

endfunction()
