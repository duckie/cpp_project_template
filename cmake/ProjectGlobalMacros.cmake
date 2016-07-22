# Check C++ version
macro(project_check_cpp_version)
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
endmacro(project_check_cpp_version)

macro(project_enable_memcheck)
  if (NOT MSVC)
    find_program(MEMORYCHECK_COMMAND valgrind)
    set(MEMORYCHECK_COMMAND_OPTIONS "--trace-children=yes --leak-check=full")
    set(MEMORYCHECK_SUPPRESSIONS_FILE "${PROJECT_SOURCE_DIR}/.valgrind_suppress.txt")
  else()
  endif()
endmacro(project_enable_memcheck)


# Add 3rdparty for main file
macro(project_add_3rdparty name)
  add_subdirectory(3rdparty/${name})
endmacro(project_add_3rdparty)

# Add module for main file
macro(project_add_module name)
  add_subdirectory(src/${name})
endmacro(project_add_module)

# Enable coverage
macro(project_enable_coverage_build)
  if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    set(CMAKE_CXX_FLAGS_COVERAGE "-g -O0 -Wall --coverage") # -fprofile-arcs -ftest-coverage")
    set(CMAKE_C_FLAGS_COVERAGE "-g -O0 -Wall --coverage") # -fprofile-arcs -ftest-coverage")
    set(CMAKE_EXE_LINKER_FLAGS_COVERAGE "--coverage") # -fprofile-arcs -ftest-coverage")
    set(CMAKE_SHARED_LINKER_FLAGS_COVERAGE "--coverage")# -fprofile-arcs -ftest-coverage")
    set(CMAKE_CXX_OUTPUT_EXTENSION_REPLACE 1)

    if ("${CMAKE_BUILD_TYPE}" STREQUAL "Coverage")
      # gcov
      find_program(GCOV_EXE gcov)
      if (NOT ${GCOV_EXE} STREQUAL GCOV_EXE-NOTFOUND)
        file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/gcov)
        message("-- gcov found, coverage reports available through target 'gcov'")
        add_custom_target(gcov
          COMMAND find ${PROJECT_BINARY_DIR} -type f -name *.gcno -exec ${GCOV_EXE} -pb {} '\;' > ${PROJECT_BINARY_DIR}/coverage/gcov/coverage.info
          COMMAND echo "Generated coverage report: " ${PROJECT_BINARY_DIR}/coverage/gcov/coverage.info
          WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/gcov
          )
      endif()

      # lcov
      find_program(LCOV_EXE lcov)
      find_program(GENHTML_EXE genhtml)
      if (NOT ${LCOV_EXE} STREQUAL LCOV_EXE-NOTFOUND AND NOT ${GENHTML_EXE} STREQUAL GENHTML_EXE-NOTFOUND)
        message("-- lcov and genhtml found, html reports available through target 'lcov'")
        file(MAKE_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/lcov/html)
        add_custom_target(lcov
          COMMAND lcov --capture --directory ${PROJECT_BINARY_DIR} --output-file coverage.info
          COMMAND genhtml coverage.info --output-directory html
          COMMAND echo "HTML report generated in: " ${PROJECT_BINARY_DIR}/coverage/lcov/html
          WORKING_DIRECTORY ${PROJECT_BINARY_DIR}/coverage/lcov
          )
      endif()
    endif()
  endif()
endmacro(project_enable_coverage_build)

# Enable sanitizers builds
macro(project_enable_sanitizer_build)
  configure_file(${PROJECT_SOURCE_DIR}/cmake/SanitizerBlacklist.txt.in ${PROJECT_BINARY_DIR}/SanitizerBlacklist.txt)
  if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "Clang")
    set(SAN ${PROJECT_BUILD_SANITIZER_TYPE})
    if (NOT ${SAN} STREQUAL "")
      if (${SAN} STREQUAL "address"
          OR ${SAN} STREQUAL "memory"
          OR ${SAN} STREQUAL "thread"
          OR ${SAN} STREQUAL "undefined")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_BINARY_DIR}/SanitizerBlacklist.txt")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_BINARY_DIR}/SanitizerBlacklist.txt")
      else()
        message(FATAL_ERROR "Clang sanitizer ${SAN} is unknown.")
      endif()
    endif()
  endif()
  if ("${CMAKE_CXX_COMPILER_ID}" MATCHES "GNU")
    set(SAN ${PROJECT_BUILD_SANITIZER_TYPE})
    if (NOT ${SAN} STREQUAL "")
      if (${SAN} STREQUAL "address"
          OR ${SAN} STREQUAL "thread"
          OR ${SAN} STREQUAL "undefined")
        set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_BINARY_DIR}/SanitizerBlacklist.txt")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS}  -fsanitize=${SAN} -fsanitize-blacklist=${PROJECT_BINARY_DIR}/SanitizerBlacklist.txt")
      else()
        message(FATAL_ERROR "Clang sanitizer ${SAN} is unknown.")
      endif()
    endif()
  endif()
endmacro(project_enable_sanitizer_build)
