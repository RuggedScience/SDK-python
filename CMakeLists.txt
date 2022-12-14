cmake_minimum_required(VERSION 3.1)

project(rssdk-python)

set(CMAKE_CXX_STANDARD 11)

set(INSTALL_UTILITIES OFF CACHE BOOL "Install utilities")
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared library")

add_subdirectory(SDK EXCLUDE_FROM_ALL)

find_package(Python3 REQUIRED COMPONENTS Interpreter)

# Create a list of sources that need to be compiled with the sdist
set(RSDIO_PYTHON_SOURCES "")
get_target_property(RSDIO_SOURCES rsdio SOURCES)
foreach(SOURCE IN LISTS RSDIO_SOURCES)
    file(RELATIVE_PATH REL_PATH ${CMAKE_CURRENT_SOURCE_DIR} ${SOURCE})
    list(APPEND RSDIO_PYTHON_SOURCES ${REL_PATH})
endforeach()

set(RSPOE_PYTHON_SOURCES "")
get_target_property(RSPOE_SOURCES rspoe SOURCES)
foreach(SOURCE IN LISTS RSPOE_SOURCES)
    file(RELATIVE_PATH REL_PATH ${CMAKE_CURRENT_SOURCE_DIR} ${SOURCE})
    list(APPEND RSPOE_PYTHON_SOURCES ${REL_PATH})
endforeach()


get_target_property(RSERRORS_SOURCES rserrors SOURCES)
foreach(SOURCE IN LISTS RSERRORS_SOURCES)
    file(RELATIVE_PATH REL_PATH ${CMAKE_CURRENT_SOURCE_DIR} ${SOURCE})
    list(APPEND RSDIO_PYTHON_SOURCES ${REL_PATH})
    list(APPEND RSPOE_PYTHON_SOURCES ${REL_PATH})
endforeach()

set_property(TARGET rsdio PROPERTY PYTHON_SOURCES ${RSDIO_PYTHON_SOURCES})
set_property(TARGET rspoe PROPERTY PYTHON_SOURCES ${RSPOE_PYTHON_SOURCES})


# Prepare Python's setup file with the sources genereated above
file(GENERATE
    OUTPUT ${CMAKE_CURRENT_SOURCE_DIR}/setup.py
    INPUT ${CMAKE_CURRENT_SOURCE_DIR}/setup.py.in
)

set(EXPORTS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/exports)

include(GenerateExportHeader)
generate_export_header(rsdio EXPORT_FILE_NAME ${EXPORTS_DIR}/rsdio_export.h)
generate_export_header(rspoe EXPORT_FILE_NAME ${EXPORTS_DIR}/rspoe_export.h)
generate_export_header(rserrors EXPORT_FILE_NAME ${EXPORTS_DIR}/rserrors_export.h)

add_custom_command(
    OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/python.stamp
    COMMAND ${Python3_EXECUTABLE} -m build -o ${CMAKE_CURRENT_BINARY_DIR}
    COMMAND ${CMAKE_COMMAND} -E touch ${CMAKE_CURRENT_BINARY_DIR}/python.stamp
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS
        ${CMAKE_CURRENT_SOURCE_DIR}/setup.py
    COMMENT "Building python bindings"
)

add_custom_target(rssdk-python ALL DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/python.stamp)
