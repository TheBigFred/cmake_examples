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

   set_target_properties(${target_name}
      PROPERTIES
         CXX_STANDARD                 11
         CXX_STANDARD_REQUIRED        YES
         DEBUG_POSTFIX                "_d"

         ARCHIVE_OUTPUT_DIRECTORY     "${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_LIBDIR}"
         LIBRARY_OUTPUT_DIRECTORY     "${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_LIBDIR}"
         RUNTIME_OUTPUT_DIRECTORY     "${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_BINDIR}"
   )

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

endfunction()
