cmake_minimum_required(VERSION 3.26)
project(cmVis LANGUAGES CXX)

# Force C++ 17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Prepare options for deps libs to be used
include(FetchContent)
include(GNUInstallDirs)

# Override CMake's default destinations
set(CMAKE_INSTALL_LIBDIR lib CACHE PATH "Library dir")
set(CMAKE_INSTALL_INCLUDEDIR include CACHE PATH "Include dir")
set(CMAKE_INSTALL_DATAROOTDIR lib CACHE PATH "Data root (force to lib)")
set(CMAKE_INSTALL_PACKAGEDIR lib/cmake CACHE PATH "CMake package config dir")

# Set external lib output and build directories
set(EXTERNAL_INSTALL_DIR "${CMAKE_BINARY_DIR}/deps")
set(EXTERNAL_BUILD_DIR "${CMAKE_BINARY_DIR}/deps/build")

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/deps")

list(PREPEND CMAKE_PREFIX_PATH "${PROJECT_BINARY_DIR}/deps/lib/cmake")
set(ENV{PKG_CONFIG_PATH} "${PROJECT_BINARY_DIR}/deps/lib/pkgconfig")

# Option to build documentation
option(BUILD_DOCS "Build documentation" OFF)

# Option to build tests
option(BUILD_TESTS "Build tests" OFF)

if(BUILD_DOCS)
    add_subdirectory(docs)
endif()

if(BUILD_TESTS)
    include(deps/gtest.cmake)
    find_package(GTest 1.17.0 EXACT REQUIRED)

    enable_testing()
    add_subdirectory(tests)
endif()

include(deps/cli11.cmake)
include(deps/json.cmake)

add_subdirectory("src")