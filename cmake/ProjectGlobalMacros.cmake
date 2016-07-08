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

# Add 3rdparty for main file
macro(project_add_3rdparty name)
  add_subdirectory(3rdparty/${name})
endmacro(project_add_3rdparty)

# Add module for main file
macro(project_add_module name)
  add_subdirectory(src/${name})
endmacro(project_add_module)
