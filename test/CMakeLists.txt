Find_Package(GTest REQUIRED)

include_directories(
  ${PROJECT_SOURCE_DIR}/includes/
  ${PROJECT_SOURCE_DIR}/src/
  ${PROJECT_SOURCE_DIR}/test/
  ${PROJECT_BINARY_DIR}/includes/
  ${PROJECT_BINARY_DIR}/src/
  ${PROJECT_BINARY_DIR}/test/
  ${GTEST_INCLUDE_DIRS}
)

add_library(test-main OBJECT test-main.cc)
add_custom_target(build-test)

function(add_cc_test name)
  if("${ARGV1}" STREQUAL "GT")
    add_executable(${name} ${name}.cc $<TARGET_OBJECTS:test-main> $<TARGET_OBJECTS:${PROJECT_NAME}>)
  else()
    add_executable(${name} ${name}.cc $<TARGET_OBJECTS:${PROJECT_NAME}>)
  endif()
  target_link_libraries(${name} ${GTEST_LIBRARIES})
  add_dependencies(build-test ${name})
  add_test(${name} ${name})  
endfunction()

add_cc_test(test1 GT)

