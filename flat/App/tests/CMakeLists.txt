################################################################################
## File      : CMakeLists.txt
## Contents  : 
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

# ==============================================================================
# == Get gtest
# ==============================================================================

if (NOT VCPKG_BUILD)
   include(FetchContent)
   FetchContent_Declare(
      googletest
         GIT_REPOSITORY https://github.com/google/googletest.git
         GIT_TAG        release-1.12.1                            # last release to support C++11
   )

   if (MSVC)
      # For Windows: Prevent overriding the parent project's compiler/linker settings
      set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
   endif()

   set(INSTALL_GTEST OFF)
   FetchContent_MakeAvailable(googletest)

   endif()

# ==============================================================================
# == Define the project targets
# ==============================================================================

set(PROJECT_TESTS ${PROJECT_NAME}-tests)
add_executable(${PROJECT_TESTS}
   main.cpp
)

add_test(
   NAME ${PROJECT_TESTS}
   COMMAND $<TARGET_FILE:${PROJECT_TESTS}>
)

set_build_flags(${PROJECT_TESTS})

target_include_directories(${PROJECT_TESTS}
   PRIVATE
      $<BUILD_INTERFACE:${PROJECT_BINARY_DIR}>
      $<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}>
)

if (VCPKG_BUILD)
   find_package(GTest CONFIG REQUIRED)
endif()

target_link_libraries(${PROJECT_TESTS}
   PRIVATE
      ${PROJECT_NAME_OBJ}
      GTest::gtest
)

if (MSVC AND BUILD_SHARED_LIBS)
   add_custom_command (TARGET ${PROJECT_TESTS} POST_BUILD
      COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different ${CMAKE_BINARY_DIR}/bin ${OUTPUT_DIRECTORY}/bin
      COMMAND ${CMAKE_COMMAND} -E copy_directory_if_different ${CMAKE_INSTALL_PREFIX}/bin ${OUTPUT_DIRECTORY}/bin/$<CONFIG>
   )
endif()
