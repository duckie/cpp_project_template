# Import configuration options into code
configure_file(config.h.cmake config.h)


file(GLOB lib_srcs *.cc)
list(REMOVE_ITEM lib_srcs "${PROJECT_SOURCE_DIR}/src/main.cc")

add_library(lib${PROJECT_NAME} ${lib_srcs})
target_link_libraries(lib${PROJECT_NAME} ${LIBRARIES})
