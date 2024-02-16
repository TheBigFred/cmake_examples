################################################################################
## File      : strip_symboles.cmake
## Contents  : strip_symboles cmake function
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

set(SYMBOLES )

function(strip_symboles target_name)
    
   if (NOT MSVC AND BUILD_SHARED_LIBS)

      set(PREFIX ${OUTPUT_DIRECTORY}/${CMAKE_INSTALL_LIBDIR})
      if (NOT "${CMAKE_CONFIGURATION_TYPES}" STREQUAL "")
         set(PREFIX ${PREFIX}/$<CONFIG>/)
      else()
         set(PREFIX ${PREFIX}/)
      endif()

      set(POSTFIX )
      get_target_property(target_type ${target_name} TYPE)
      if (target_type STREQUAL "SHARED_LIBRARY")
         set(POSTFIX .so)
      endif()

      set(FILENAME $<IF:$<CONFIG:Debug>,${PREFIX}${target_name}_d${POSTFIX},${PREFIX}${target_name}${POSTFIX}>)
      set(FILENAME_D ${FILENAME}.debug)

      add_custom_command(TARGET ${target_name} POST_BUILD
         COMMAND ${CMAKE_OBJCOPY} --only-keep-debug ${FILENAME} ${FILENAME_D}
         COMMAND ${CMAKE_OBJCOPY} --strip-debug ${FILENAME}
         COMMAND ${CMAKE_OBJCOPY} --add-gnu-debuglink=${FILENAME_D} ${FILENAME}
      )

      set(SYMBOLES ${SYMBOLES} ${FILENAME_D} PARENT_SCOPE)

   endif()

endfunction()
