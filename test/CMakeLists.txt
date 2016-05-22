include_directories(
  ${PROJECT_SOURCE_DIR}/3rdparty/catch
)

add_library(catch_main OBJECT catch_main.cc)
set(catch_exe_source_list)
add_custom_target(build-test)
macro(add_project_test name)
  if("${ARGV1}" STREQUAL "CATCH")
    list(APPEND catch_exe_source_list ${name}.cc)
  else()
    add_executable(${name} ${name}.cc)
    target_link_libraries(${name} lib${PROJECT_NAME} ${CMAKE_THREAD_LIBS_INIT})
    add_dependencies(build-test ${name})
    add_test(${name} ${name})  
  endif()
endmacro()

add_project_test(test1 CATCH)

add_executable(unit_tests ${catch_exe_source_list} $<TARGET_OBJECTS:catch_main>)
target_link_libraries(unit_tests lib${PROJECT_NAME})

