################################################################################
## File      : logger_severity.cmake
## Contents  : set logger minimum verbosity
##
## Author    : TheBigFred - thebigfred.github@gmail.com
## URL       : https://github.com/TheBigFred/cmake_examples
##
##-----------------------------------------------------------------------------
##  LGPL V3.0 - https://www.gnu.org/licences/lgpl-3.0.txt
##-----------------------------------------------------------------------------
################################################################################

set(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} "Default" CACHE STRING "Logger verbosity chosen by the user at CMake configure time")
set(LoggerVerbosityValues "Default;Debug;Verbose;Info;Warning;Error;Force")
set_property(CACHE LOGGER_MIN_VERBOSITY_${PROJECT_NAME} PROPERTY STRINGS ${LoggerVerbosityValues})

if(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Force")
   set(LOGGER_SEV_${PROJECT_NAME} 0)

elseif(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Error")
   set(LOGGER_SEV_${PROJECT_NAME} 1)

elseif(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Warning")
   set(LOGGER_SEV_${PROJECT_NAME} 2)

elseif(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Info")
   set(LOGGER_SEV_${PROJECT_NAME} 3)

elseif(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Verbose")
   set(LOGGER_SEV_${PROJECT_NAME} 4)

elseif(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Debug")
   set(LOGGER_SEV_${PROJECT_NAME} 5)

elseif(LOGGER_MIN_VERBOSITY_${PROJECT_NAME} STREQUAL "Default")
   set(LOGGER_SEV_${PROJECT_NAME} $<$<NOT:$<CONFIG:DEBUG>>:3>$<$<CONFIG:DEBUG>:4>)

else()
   message(STATUS "Using default logger severity")
   set(LOGGER_SEV_${PROJECT_NAME} 3)

endif()
