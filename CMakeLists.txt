cmake_minimum_required (VERSION 2.8)
project (cppproject)
enable_testing()

set(CMAKE_VERBOSE_MAKEFILE OFF)

# C++11 is a requirement here
include(CheckCXXCompilerFlag)
check_cxx_compiler_flag(-std=c++11 HAVE_STD_CPP11_FLAG)
if (HAVE_STD_CPP11_FLAG)
  message("-- C++11 support found.")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
else()
  message(FATAL_ERROR "Your compiler must support C++11 to compile ${PROJECT_NAME}.")
endif()

# Loading user config
set(OpenCV_USER FALSE)
set(Boost_USE FALSE)
set(Boost_COMPONENTS "")

# Main source directory
add_subdirectory (src)
add_subdirectory (test)

