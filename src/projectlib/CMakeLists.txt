## Dependencies snippets ##

set(LIBRARIES)
set(CURRENT_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR})
set(CURRENT_INCLUDES ${CMAKE_CURRENT_SOURCE_DIR}/includes ${CMAKE_CURRENT_BINARY_DIR}/includes)
set(CURRENT_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src ${CMAKE_CURRENT_BINARY_DIR}/src)

## OpenCV support
#find_package(OpenCV REQUIRED)
#if(OpenCV_FOUND)
#    include_directories(${OpenCV_INCLUDE_DIRS})
#    set(LIBRARIES "${LIBRARIES}" "${OpenCV_LIBS}")
#endif()

## Boost support
#find_package(Boost COMPONENTS ${Boost_COMPONENTS} REQUIRED)
#if(Boost_FOUND)
# include_directories(${Boost_INCLUDE_DIRS})
#    if(CMAKE_COMPILER_IS_GNUCXX)
#        set(LIBRARIES "${LIBRARIES}" "${Boost_LIBRARIES}")
#    else()
#        link_directories(${Boost_LIBRARY_DIRS})
#    endif()
#endif()

# Import configuration options into code
include_directories(${CURRENT_INCLUDES})
configure_file(includes/config.h.cmake config.h)
file(GLOB lib_sources src/*.cc)
add_library(${PROJECT_NAME} ${lib_sources})
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})

add_subdirectory(test)
