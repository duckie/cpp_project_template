configure_file(config.h.cmake config.h)

include_directories(
    ${PROJECT_SOURCE_DIR}/src 
    ${PROJECT_BINARY_DIR}/src
	)

set(LIBRARIES)

### MANUAL_INCLUDE_DIRS is useful to force ides to find some includes (useless for compilation) ###
### To be used by editing the cache manually
include_directories(${MANUAL_INCLUDE_DIRS})

### OpenCV support ###
if(OpenCV_USE)
    FIND_PACKAGE(OpenCV REQUIRED)
    if(OpenCV_FOUND)
        include_directories(${OpenCV_INCLUDE_DIRS})
        set(LIBRARIES "${LIBRARIES}" "${OpenCV_LIBS}")
    endif()
endif()

### Boost support ###
if(Boost_USE)
    FIND_PACKAGE(Boost COMPONENTS ${Boost_COMPONENTS} REQUIRED)
    if(Boost_FOUND)
	    include_directories(${Boost_INCLUDE_DIRS})
        if(CMAKE_COMPILER_IS_GNUCXX)
            set(LIBRARIES "${LIBRARIES}" "${Boost_LIBRARIES}")
        else()
            link_directories(${Boost_LIBRARY_DIRS})
        endif()
    endif()
endif()

### Browsing source files ###
file(GLOB SRCS_FILES *.cc)

### Exe ###
add_executable(${PROJECT_NAME} ${SRCS_FILES}) 

### Linking ###
target_link_libraries(${PROJECT_NAME} ${LIBRARIES})
