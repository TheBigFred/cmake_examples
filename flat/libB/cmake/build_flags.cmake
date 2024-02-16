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

   # set runtime path (aka RPATH)
   if ((NOT MSVC) AND BUILD_SHARED_LIBS)

      file(RELATIVE_PATH _rel ${CMAKE_INSTALL_PREFIX}/${CMAKE_INSTALL_BINDIR} ${CMAKE_INSTALL_PREFIX})

      if (APPLE)
         set(_rpath "@loader_path/${_rel}")
      else()
         set(_rpath "\$ORIGIN/${_rel}")
      endif()
      file(TO_NATIVE_PATH "${_rpath}/${CMAKE_INSTALL_LIBDIR}" __rpath)

      set_target_properties(${target_name}
         PROPERTIES
            MACOSX_RPATH                  ON
            SKIP_BUILD_RPATH              OFF
            BUILD_WITH_INSTALL_RPATH      OFF
            INSTALL_RPATH                 "${__rpath}"
            INSTALL_RPATH_USE_LINK_PATH   ON
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
      PUBLIC
         $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
         $<INSTALL_INTERFACE:include>
   )

   if(NOT PROJECT_IS_TOP_LEVEL)
      # Superbuild
      target_include_directories(${target_name}
         PUBLIC
            $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}>
            $<BUILD_INTERFACE:${CMAKE_BINARY_DIR}>
      )
   endif()

endfunction()
