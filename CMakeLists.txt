# C++ Project template
#
# Proudly bootstrapped by git@github.com:duckie/cpp_project_template.git
#

# Version guard
cmake_minimum_required (VERSION 2.8)

# Cmake modules
include(CheckCXXSourceCompiles)
include(CheckCXXCompilerFlag)
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake")
include(ProjectGlobalMacros)

# Project configuration
project (cppproject)
enable_testing()
set(CMAKE_VERBOSE_MAKEFILE OFF)

# Check for C++11/14 support
project_check_cpp_version()

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

# Add flags for coverage
set(CMAKE_CXX_FLAGS_COVERAGE "-g -O0 -Wall --coverage") # -fprofile-arcs -ftest-coverage")
set(CMAKE_C_FLAGS_COVERAGE "-g -O0 -Wall --coverage") # -fprofile-arcs -ftest-coverage")
set(CMAKE_EXE_LINKER_FLAGS_COVERAGE "--coverage") # -fprofile-arcs -ftest-coverage")
set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE "--coverage")# -fprofile-arcs -ftest-coverage")

### MANUAL_INCLUDE_DIRS is useful to force ides to find some includes (useless for compilation) ###
### To be used by editing the cache manually
include_directories(${MANUAL_INCLUDE_DIRS})

project_add_3rdparty(catch)

# By default we put binaries into this directory
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

project_add_module(testlib)
project_add_module(projectlib)
project_add_module(projectrun)

# Tooling

# Format the whole source code with clang-format
file(GLOB_RECURSE srcs_to_format src/*.c src/*.cc src/*.cpp src/*.cxx)
file(GLOB_RECURSE headers_to_format src/*.h src/*.hpp src/*.hxx)
add_custom_target(format
  clang-format -i ${srcs_to_format} ${headers_to_format}
  VERBATIM
)
