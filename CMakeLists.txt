cmake_minimum_required (VERSION 2.6)
include(CheckIncludeFileCXX)

project (CppProject)

set(CMAKE_VERBOSE_MAKEFILE OFF)

# Making more readable error messages in eclipse
if(CMAKE_COMPILER_IS_GNUCC)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fmessage-length=0")
endif(CMAKE_COMPILER_IS_GNUCC)
if(CMAKE_COMPILER_IS_GNUCXX)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fmessage-length=0")
endif(CMAKE_COMPILER_IS_GNUCXX)

# Loading user config
include(config.cmake)

# Detecting platform
STRING(COMPARE EQUAL ${CMAKE_SYSTEM_NAME} "Windows" COMPILE_ON_WINDOWS)
STRING(COMPARE EQUAL ${CMAKE_SYSTEM_NAME} "Linux" COMPILE_ON_LINUX)

if(COMPILE_ON_WINDOWS)
    set(${WINDOWS} ON)
endif()

if(COMPILE_ON_LINUX)
    set(${UNIX} ON)
endif()

# Centralized version number
include (version.cmake)
message (STATUS "*** Building ${PROJECT_NAME} ${PROJECT_VERSION} ***")
message (STATUS "${CMAKE_SYSTEM_NAME} detected")

# Main source directory
add_subdirectory (src)

