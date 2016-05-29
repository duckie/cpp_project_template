# Version guard
cmake_minimum_required (VERSION 2.8)

# Cmake modules
include(CheckCXXSourceCompiles)
include(CheckCXXCompilerFlag)

# Project configuration
project (cppproject)
enable_testing()
set(CMAKE_VERBOSE_MAKEFILE OFF)

# Check for C++11/14 support
if (NOT MSVC)
  # Tests for Clang and GCC
  check_cxx_compiler_flag(-std=c++1y CPP14_SUPPORT)
  if (CPP14_SUPPORT)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++1y")
    message("-- C++14 support found.")
  else()
    check_cxx_compiler_flag(-std=c++11 CPP11_SUPPORT)
    if (CPP11_SUPPORT)
      set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
      message("-- C++11 support found.")
    endif()
  endif()
else()
  # Tests for MSVC
  # Unfortunately, due to various unsupported things in msvc versions,
  # this is poor informatiion about actual support
  check_cxx_source_compiles("#include <utility>\nusing std::integer_sequence;\n int main(){return 0;}" CPP14_SUPPORT)
  if (CPP14_SUPPORT)
    message("-- C++14 support found.")
  else()
    check_cxx_source_compiles("static constexpr int TEST=0;\n int main(){return 0;}" CPP11_SUPPORT)
    if (CPP11_SUPPORT)
      message("-- C++11 support found.")
    endif()
  endif ()
endif()

## Snippets to enforce a C++ version
#if (not CPP14_SUPPORT)
#  message(FATAL_ERROR "C++14 support is required.")
#endif()
#if (not CPP11_SUPPORT)
#  message(FATAL_ERROR "C++11 support is required.")
#endif()

# Trace compilation for tools (ex: YouCompleteMe)
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
configure_file(${PROJECT_SOURCE_DIR}/cmake/BuildConfig.json.in ${PROJECT_SOURCE_DIR}/BuildConfig.json)

# Format the whole source code with clang-format
file(GLOB_RECURSE srcs_to_format src/*.cc)
file(GLOB_RECURSE headers_to_format include/*.h)
file(GLOB_RECURSE private_headers_to_format src/*.h)
add_custom_target(format
  clang-format -i ${srcs_to_format} ${headers_to_format} ${private_headers_to_format}
  VERBATIM
)

### MANUAL_INCLUDE_DIRS is useful to force ides to find some includes (useless for compilation) ###
### To be used by editing the cache manually
include_directories(${MANUAL_INCLUDE_DIRS})

macro(enable_3rdparty name)
  add_subdirectory(3rdparty/${name})
endmacro(enable_3rdparty)

enable_3rdparty(catch)

# By default we put binaries into this directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

macro(enable_module name)
  add_subdirectory(src/${name})
endmacro(enable_module)

enable_module(testlib)
enable_module(projectlib)
enable_module(projectrun)

